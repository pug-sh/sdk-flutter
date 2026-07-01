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

  @$pb.TagNumber(1)
  $pb.PbList<Event> get events => $_getList(0);
}

class BatchCreateResponse extends $pb.GeneratedMessage {
  factory BatchCreateResponse({
    $core.int? accepted,
  }) {
    final result = create();
    if (accepted != null) result.accepted = accepted;
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

  @$pb.TagNumber(7)
  $core.String get sessionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set sessionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSessionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearSessionId() => $_clearField(7);
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
