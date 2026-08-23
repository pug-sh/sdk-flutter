import 'dart:async';
import 'dart:math';

import 'configuration.dart';
import 'connect_transport.dart';
import 'contracts.dart';
import 'errors.dart';
import 'event_queue_storage.dart';
import 'events.dart';

/// Owns delivery: the queue, the transport, the flush timer, and the policy
/// for what a failed send means.
///
/// Permanent transport failures drop the batch or event; transient ones roll
/// back and retry with backoff. See `## Design Invariants` in CLAUDE.md — the
/// queue's lock/commit/rollback protocol is what keeps in-flight events from
/// being dropped, so it is interpreted here and nowhere else.
class EventDispatcher {
  EventDispatcher({
    required PugEventQueue queue,
    required PugTransport transport,
    required PugLogger logger,
    required BatchConfig batch,
    required bool dryRun,
    required bool ownsTransport,
  }) : _queue = queue,
       _transport = transport,
       _logger = logger,
       _batch = batch,
       _dryRun = dryRun,
       _ownsTransport = ownsTransport;

  final PugEventQueue _queue;
  final PugTransport _transport;
  final PugLogger _logger;
  final BatchConfig _batch;
  final bool _dryRun;

  /// False when the host injected the transport: it may be shared with another
  /// client, and closing its http.Client would wedge that one's sends behind a
  /// "Client is already closed" error the retry policy treats as transient.
  final bool _ownsTransport;
  Timer? _flushTimer;
  Future<void> _inFlight = Future<void>.value();
  bool _disposed = false;
  bool _released = false;

  PugEventQueue get queue => _queue;

  /// Counts locked events too: a batch that is in flight when `destroy()` runs
  /// is still undelivered, and reporting only [PugEventQueue.size] would make
  /// the discarded-events warning miss exactly that case.
  int get pending => _queue.totalSize;

  void dispatch(Event event, {required bool immediate}) {
    if (immediate) {
      unawaited(_sendImmediateOrQueue(event));
      return;
    }
    _queue.push(event);
    if (_queue.size >= _batch.maxSize) {
      unawaited(flush());
    } else {
      scheduleFlush();
    }
  }

  /// Flushes serially: a call made while a batch is in flight queues behind it
  /// rather than returning a no-op, so [flushAll] can wait for work it did not
  /// start.
  Future<void> flush() {
    if (_disposed || _released || _dryRun) {
      return _inFlight;
    }
    final next = _inFlight.then((_) => _flushOnce());
    _inFlight = next;
    return next;
  }

  Future<void> flushAll() async {
    await _inFlight;
    while (!_disposed && !_released && !_dryRun && _queue.size > 0) {
      final before = _queue.size;
      await flush();
      if (_queue.size >= before) {
        break;
      }
    }
  }

  void scheduleFlush({bool withBackoff = false}) {
    if (_disposed) {
      return;
    }
    _flushTimer?.cancel();
    final wait =
        withBackoff
            ? Duration(milliseconds: max(_batch.maxWaitMs, 1000) * 2)
            : Duration(milliseconds: _batch.maxWaitMs);
    _flushTimer = Timer(wait, () => unawaited(flush()));
  }

  void cancelScheduledFlush() {
    _flushTimer?.cancel();
  }

  /// Another client has taken over this queue's storage namespace and has
  /// already adopted its persisted events: stop sending, so they are not
  /// delivered twice, and stop persisting, so the new owner's writes stand.
  void release() {
    _released = true;
    _queue.detachStorage();
  }

  /// [persistQueue] is false when the caller no longer owns the storage
  /// namespace: writing the queue back would clobber a replacement client's.
  void dispose({bool persistQueue = true}) {
    _disposed = true;
    _flushTimer?.cancel();
    if (persistQueue) {
      _queue.dispose();
    }
    if (_ownsTransport && _transport is ConnectPugTransport) {
      _transport.close();
    }
  }

  Future<void> _flushOnce() async {
    if (_disposed || _released || _dryRun || _queue.size == 0) {
      return;
    }
    try {
      final events = _queue.lock(_batch.maxSize);
      if (events.isEmpty) {
        return;
      }
      await _transport.sendBatch(events);
      // destroy() can land across the await; committing or rolling back then
      // re-persists this batch into a queue key it has already purged.
      if (_disposed) {
        return;
      }
      _queue.commit();
    } on PugTransportException catch (error, stackTrace) {
      if (!_disposed) {
        if (error.isPermanent) {
          _logger.error('Pug dropped a permanently rejected batch.', error);
          _queue.commit();
        } else {
          _logger.warn('Pug batch send failed; it will be retried.');
          _queue.rollback();
          scheduleFlush(withBackoff: true);
        }
      }
      if (error.stackTrace != null) {
        _logger.debug(error.stackTrace.toString());
      }
      _logger.debug(stackTrace.toString());
    } catch (error, stackTrace) {
      _logger.error(
        'Pug dropped a batch after an unexpected transport failure.',
        error,
        stackTrace,
      );
      if (!_disposed) {
        _queue.commit();
      }
      _logger.debug(stackTrace.toString());
    }
  }

  Future<void> _sendImmediateOrQueue(Event event) async {
    try {
      await _transport.send(event);
    } on PugTransportException catch (error) {
      if (error.isPermanent) {
        _logger.error('Pug dropped a permanently rejected event.', error);
      } else if (!_disposed && !_released) {
        _queue.push(event);
        scheduleFlush(withBackoff: true);
      }
    } catch (error, stackTrace) {
      _logger.error(
        'Pug dropped an event after an unexpected transport failure.',
        error,
        stackTrace,
      );
    }
  }
}
