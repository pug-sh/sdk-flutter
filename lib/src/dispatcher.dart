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
  }) : _queue = queue,
       _transport = transport,
       _logger = logger,
       _batch = batch,
       _dryRun = dryRun;

  final PugEventQueue _queue;
  final PugTransport _transport;
  final PugLogger _logger;
  final BatchConfig _batch;
  final bool _dryRun;
  Timer? _flushTimer;
  bool _isFlushing = false;
  bool _disposed = false;

  PugEventQueue get queue => _queue;

  int get pending => _queue.size;

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

  Future<void> flush() async {
    if (_isFlushing || _disposed || _dryRun || _queue.size == 0) {
      return;
    }
    _isFlushing = true;
    try {
      final events = _queue.lock(_batch.maxSize);
      if (events.isEmpty) {
        return;
      }
      await _transport.sendBatch(events);
      _queue.commit();
    } on PugTransportException catch (error, stackTrace) {
      if (error.isPermanent) {
        _logger.error('Pug dropped a permanently rejected batch.', error);
        _queue.commit();
      } else {
        _logger.warn('Pug batch send failed; it will be retried.');
        _queue.rollback();
        scheduleFlush(withBackoff: true);
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
      _queue.commit();
      _logger.debug(stackTrace.toString());
    } finally {
      _isFlushing = false;
    }
  }

  Future<void> flushAll() async {
    while (!_disposed && !_dryRun && _queue.size > 0) {
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

  void dispose() {
    _disposed = true;
    _flushTimer?.cancel();
    _queue.dispose();
    if (_transport case final ConnectPugTransport transport) {
      transport.close();
    }
  }

  Future<void> _sendImmediateOrQueue(Event event) async {
    try {
      await _transport.send(event);
    } on PugTransportException catch (error) {
      if (error.isPermanent) {
        _logger.error('Pug dropped a permanently rejected event.', error);
      } else {
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
