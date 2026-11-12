// This is a generated file - do not edit.
//
// Generated from sdk/events/v1/events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import '../../../common/v1/property_value.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class BatchCreateRequest extends $pb.GeneratedMessage {
  factory BatchCreateRequest({
    $core.Iterable<Event>? events,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    return result;
  }

  BatchCreateRequest._();

  factory BatchCreateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchCreateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchCreateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.events.v1'),
      createEmptyInstance: create)
    ..pPM<Event>(1, _omitFieldNames ? '' : 'events', subBuilder: Event.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateRequest copyWith(void Function(BatchCreateRequest) updates) =>
      super.copyWith((message) => updates(message as BatchCreateRequest))
          as BatchCreateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateRequest create() => BatchCreateRequest._();
  @$core.override
  BatchCreateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchCreateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchCreateRequest>(create);
  static BatchCreateRequest? _defaultInstance;

  /// BatchCreate validates each event on its own, as an IncomingEvent, so an
  /// event that breaks a rule, or repeats an earlier kept event's event_id, is
  /// dropped as invalid_event and the rest are kept.
  @$pb.TagNumber(1)
  $pb.PbList<Event> get events => $_getList(0);
}

class BatchCreateResponse extends $pb.GeneratedMessage {
  factory BatchCreateResponse({
    $core.int? accepted,
    $core.int? dropped,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? droppedByReason,
    $core.Iterable<InvalidEvent>? invalidEvents,
  }) {
    final result = create();
    if (accepted != null) result.accepted = accepted;
    if (dropped != null) result.dropped = dropped;
    if (droppedByReason != null)
      result.droppedByReason.addEntries(droppedByReason);
    if (invalidEvents != null) result.invalidEvents.addAll(invalidEvents);
    return result;
  }

  BatchCreateResponse._();

  factory BatchCreateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchCreateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchCreateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.events.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'accepted', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'dropped', fieldType: $pb.PbFieldType.OU3)
    ..m<$core.String, $core.int>(3, _omitFieldNames ? '' : 'droppedByReason',
        entryClassName: 'BatchCreateResponse.DroppedByReasonEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OU3,
        packageName: const $pb.PackageName('sdk.events.v1'))
    ..pPM<InvalidEvent>(4, _omitFieldNames ? '' : 'invalidEvents',
        subBuilder: InvalidEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchCreateResponse copyWith(void Function(BatchCreateResponse) updates) =>
      super.copyWith((message) => updates(message as BatchCreateResponse))
          as BatchCreateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateResponse create() => BatchCreateResponse._();
  @$core.override
  BatchCreateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchCreateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchCreateResponse>(create);
  static BatchCreateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get accepted => $_getIZ(0);
  @$pb.TagNumber(1)
  set accepted($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccepted() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccepted() => $_clearField(1);

  /// Events the server refused to ingest; accepted + dropped equals the number
  /// sent. A drop is deliberately not an error: a batch may legitimately mix
  /// cookieless and consented events, so failing the request would discard
  /// healthy traffic to report a fault affecting only part of it. That makes
  /// this field the only signal to the caller that anything was lost.
  @$pb.TagNumber(2)
  $core.int get dropped => $_getIZ(1);
  @$pb.TagNumber(2)
  set dropped($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDropped() => $_has(1);
  @$pb.TagNumber(2)
  void clearDropped() => $_clearField(2);

  /// Per-reason breakdown of `dropped`, keyed by a stable reason token. This is
  /// what makes a drop actionable rather than merely visible: `salt_unavailable`
  /// is a server-side fault and the same payload may be retried, whereas
  /// `day_out_of_range` is client clock skew and `invalid_event` an event that
  /// broke a validation rule or repeated an earlier kept event's event_id, and
  /// both drop again on every retry.
  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.int> get droppedByReason => $_getMap(2);

  /// The events dropped as `invalid_event`, in request order.
  @$pb.TagNumber(4)
  $pb.PbList<InvalidEvent> get invalidEvents => $_getList(3);
}

class InvalidEvent extends $pb.GeneratedMessage {
  factory InvalidEvent({
    $core.int? index,
    $core.Iterable<$core.String>? violations,
  }) {
    final result = create();
    if (index != null) result.index = index;
    if (violations != null) result.violations.addAll(violations);
    return result;
  }

  InvalidEvent._();

  factory InvalidEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvalidEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvalidEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.events.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'index', fieldType: $pb.PbFieldType.OU3)
    ..pPS(2, _omitFieldNames ? '' : 'violations')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidEvent copyWith(void Function(InvalidEvent) updates) =>
      super.copyWith((message) => updates(message as InvalidEvent))
          as InvalidEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvalidEvent create() => InvalidEvent._();
  @$core.override
  InvalidEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InvalidEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvalidEvent>(create);
  static InvalidEvent? _defaultInstance;

  /// Position in BatchCreateRequest.events, counting from 0.
  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => $_clearField(1);

  /// The rules it broke, e.g. "event.kind: does not match regex pattern `^[a-zA-Z0-9_.-]+$`".
  /// At most 10, then one more entry that counts the rest, e.g. "and 3 more".
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get violations => $_getList(1);
}

/// Never sent. BatchCreate validates each event as one: Event's rules plus two
/// that hold only at the SDK boundary, since the server fills a cookieless
/// event's identity with 'cookieless-' ids before the EventBatch envelope
/// re-validates it.
class IncomingEvent extends $pb.GeneratedMessage {
  factory IncomingEvent({
    Event? event,
  }) {
    final result = create();
    if (event != null) result.event = event;
    return result;
  }

  IncomingEvent._();

  factory IncomingEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncomingEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncomingEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.events.v1'),
      createEmptyInstance: create)
    ..aOM<Event>(1, _omitFieldNames ? '' : 'event', subBuilder: Event.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomingEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomingEvent copyWith(void Function(IncomingEvent) updates) =>
      super.copyWith((message) => updates(message as IncomingEvent))
          as IncomingEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncomingEvent create() => IncomingEvent._();
  @$core.override
  IncomingEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IncomingEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncomingEvent>(create);
  static IncomingEvent? _defaultInstance;

  @$pb.TagNumber(1)
  Event get event => $_getN(0);
  @$pb.TagNumber(1)
  set event(Event value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  Event ensureEvent() => $_ensure(0);
}

class Event extends $pb.GeneratedMessage {
  factory Event({
    $core.String? eventId,
    $core.Iterable<$core.MapEntry<$core.String, $1.PropertyValue>>?
        autoProperties,
    $core.Iterable<$core.MapEntry<$core.String, $1.PropertyValue>>?
        customProperties,
    $core.String? distinctId,
    $core.String? kind,
    $0.Timestamp? occurTime,
    $core.String? sessionId,
    $core.bool? cookieless,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (autoProperties != null)
      result.autoProperties.addEntries(autoProperties);
    if (customProperties != null)
      result.customProperties.addEntries(customProperties);
    if (distinctId != null) result.distinctId = distinctId;
    if (kind != null) result.kind = kind;
    if (occurTime != null) result.occurTime = occurTime;
    if (sessionId != null) result.sessionId = sessionId;
    if (cookieless != null) result.cookieless = cookieless;
    return result;
  }

  Event._();

  factory Event.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Event.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Event',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..m<$core.String, $1.PropertyValue>(
        2, _omitFieldNames ? '' : 'autoProperties',
        entryClassName: 'Event.AutoPropertiesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.PropertyValue.create,
        valueDefaultOrMaker: $1.PropertyValue.getDefault,
        packageName: const $pb.PackageName('sdk.events.v1'))
    ..m<$core.String, $1.PropertyValue>(
        3, _omitFieldNames ? '' : 'customProperties',
        entryClassName: 'Event.CustomPropertiesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $1.PropertyValue.create,
        valueDefaultOrMaker: $1.PropertyValue.getDefault,
        packageName: const $pb.PackageName('sdk.events.v1'))
    ..aOS(4, _omitFieldNames ? '' : 'distinctId')
    ..aOS(5, _omitFieldNames ? '' : 'kind')
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'occurTime',
        subBuilder: $0.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'sessionId')
    ..aOB(8, _omitFieldNames ? '' : 'cookieless')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event copyWith(void Function(Event) updates) =>
      super.copyWith((message) => updates(message as Event)) as Event;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  @$core.override
  Event createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $1.PropertyValue> get autoProperties => $_getMap(1);

  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $1.PropertyValue> get customProperties => $_getMap(2);

  /// Empty only when cookieless (event.identity_required_unless_cookieless);
  /// never client-settable to a 'cookieless-'-prefixed value
  /// (incoming_event.distinct_id_reserved_prefix).
  @$pb.TagNumber(4)
  $core.String get distinctId => $_getSZ(3);
  @$pb.TagNumber(4)
  set distinctId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDistinctId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDistinctId() => $_clearField(4);

  /// Same character set as common.v1.EventFilter.kind (filters.proto); + requires non-empty at ingest.
  @$pb.TagNumber(5)
  $core.String get kind => $_getSZ(4);
  @$pb.TagNumber(5)
  set kind($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasKind() => $_has(4);
  @$pb.TagNumber(5)
  void clearKind() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.Timestamp get occurTime => $_getN(5);
  @$pb.TagNumber(6)
  set occurTime($0.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOccurTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearOccurTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureOccurTime() => $_ensure(5);

  /// A UUID whenever set; omit entirely in cookieless mode (an explicit "" also
  /// drops the event as invalid_event, since a set field must be a UUID).
  @$pb.TagNumber(7)
  $core.String get sessionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set sessionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSessionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearSessionId() => $_clearField(7);

  /// Cookieless (no-consent) mode: the client stores nothing on the device and
  /// sends no identity; the ingest server derives an ephemeral daily-rotating
  /// distinct_id and a stitched session_id. See docs/architecture/ingestion.md.
  @$pb.TagNumber(8)
  $core.bool get cookieless => $_getBF(7);
  @$pb.TagNumber(8)
  set cookieless($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCookieless() => $_has(7);
  @$pb.TagNumber(8)
  void clearCookieless() => $_clearField(8);
}

class EventBatch extends $pb.GeneratedMessage {
  factory EventBatch({
    $core.Iterable<Event>? events,
    $core.String? projectId,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (projectId != null) result.projectId = projectId;
    return result;
  }

  EventBatch._();

  factory EventBatch.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventBatch.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventBatch',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.events.v1'),
      createEmptyInstance: create)
    ..pPM<Event>(1, _omitFieldNames ? '' : 'events', subBuilder: Event.create)
    ..aOS(2, _omitFieldNames ? '' : 'projectId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventBatch clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventBatch copyWith(void Function(EventBatch) updates) =>
      super.copyWith((message) => updates(message as EventBatch)) as EventBatch;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventBatch create() => EventBatch._();
  @$core.override
  EventBatch createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventBatch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventBatch>(create);
  static EventBatch? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Event> get events => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectId() => $_clearField(2);
}

class EventsServiceApi {
  final $pb.RpcClient _client;

  EventsServiceApi(this._client);

  $async.Future<BatchCreateResponse> batchCreate(
          $pb.ClientContext? ctx, BatchCreateRequest request) =>
      _client.invoke<BatchCreateResponse>(
          ctx, 'EventsService', 'BatchCreate', request, BatchCreateResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
