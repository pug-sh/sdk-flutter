// This is a generated file - do not edit.
//
// Generated from shared/activity/v1/activity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $3;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $2;

import '../../../common/v1/filter_schema.pb.dart' as $4;
import '../../../common/v1/filters.pb.dart' as $1;
import '../../../common/v1/time.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetActivityFeedRequest extends $pb.GeneratedMessage {
  factory GetActivityFeedRequest({
    $core.String? distinctId,
    $core.String? sessionId,
    $0.TimeRange? timeRange,
    $core.Iterable<$1.PropertyFilter>? propertyFilters,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$1.EventFilter>? events,
  }) {
    final result = create();
    if (distinctId != null) result.distinctId = distinctId;
    if (sessionId != null) result.sessionId = sessionId;
    if (timeRange != null) result.timeRange = timeRange;
    if (propertyFilters != null) result.propertyFilters.addAll(propertyFilters);
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (events != null) result.events.addAll(events);
    return result;
  }

  GetActivityFeedRequest._();

  factory GetActivityFeedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetActivityFeedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetActivityFeedRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'distinctId')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..aOM<$0.TimeRange>(3, _omitFieldNames ? '' : 'timeRange',
        subBuilder: $0.TimeRange.create)
    ..pPM<$1.PropertyFilter>(4, _omitFieldNames ? '' : 'propertyFilters',
        subBuilder: $1.PropertyFilter.create)
    ..aI(5, _omitFieldNames ? '' : 'pageSize')
    ..aOS(6, _omitFieldNames ? '' : 'pageToken')
    ..pPM<$1.EventFilter>(7, _omitFieldNames ? '' : 'events',
        subBuilder: $1.EventFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityFeedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityFeedRequest copyWith(
          void Function(GetActivityFeedRequest) updates) =>
      super.copyWith((message) => updates(message as GetActivityFeedRequest))
          as GetActivityFeedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActivityFeedRequest create() => GetActivityFeedRequest._();
  @$core.override
  GetActivityFeedRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetActivityFeedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetActivityFeedRequest>(create);
  static GetActivityFeedRequest? _defaultInstance;

  /// Required. The profile ID to fetch events for.
  @$pb.TagNumber(1)
  $core.String get distinctId => $_getSZ(0);
  @$pb.TagNumber(1)
  set distinctId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDistinctId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDistinctId() => $_clearField(1);

  /// Optional. Filter by session. Empty means all sessions.
  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  /// Optional. Restrict to events within this time window.
  @$pb.TagNumber(3)
  $0.TimeRange get timeRange => $_getN(2);
  @$pb.TagNumber(3)
  set timeRange($0.TimeRange value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeRange() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeRange() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.TimeRange ensureTimeRange() => $_ensure(2);

  /// Optional. Filter by event properties (auto or custom).
  @$pb.TagNumber(4)
  $pb.PbList<$1.PropertyFilter> get propertyFilters => $_getList(3);

  /// 0 means server default (100). Max 1000.
  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);

  /// Opaque cursor from a previous response's next_page_token. Empty for the first page.
  @$pb.TagNumber(6)
  $core.String get pageToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set pageToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPageToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageToken() => $_clearField(6);

  /// Optional. Filter by multiple event types with per-event property filters.
  @$pb.TagNumber(7)
  $pb.PbList<$1.EventFilter> get events => $_getList(6);
}

class ActivityEvent extends $pb.GeneratedMessage {
  factory ActivityEvent({
    $core.String? eventId,
    $core.String? kind,
    $core.String? distinctId,
    $2.Timestamp? occurTime,
    $core.String? sessionId,
    $3.Struct? autoProperties,
    $3.Struct? customProperties,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (kind != null) result.kind = kind;
    if (distinctId != null) result.distinctId = distinctId;
    if (occurTime != null) result.occurTime = occurTime;
    if (sessionId != null) result.sessionId = sessionId;
    if (autoProperties != null) result.autoProperties = autoProperties;
    if (customProperties != null) result.customProperties = customProperties;
    return result;
  }

  ActivityEvent._();

  factory ActivityEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActivityEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActivityEvent',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aOS(3, _omitFieldNames ? '' : 'distinctId')
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'occurTime',
        subBuilder: $2.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'sessionId')
    ..aOM<$3.Struct>(6, _omitFieldNames ? '' : 'autoProperties',
        subBuilder: $3.Struct.create)
    ..aOM<$3.Struct>(7, _omitFieldNames ? '' : 'customProperties',
        subBuilder: $3.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivityEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivityEvent copyWith(void Function(ActivityEvent) updates) =>
      super.copyWith((message) => updates(message as ActivityEvent))
          as ActivityEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivityEvent create() => ActivityEvent._();
  @$core.override
  ActivityEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ActivityEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActivityEvent>(create);
  static ActivityEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get distinctId => $_getSZ(2);
  @$pb.TagNumber(3)
  set distinctId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDistinctId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDistinctId() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get occurTime => $_getN(3);
  @$pb.TagNumber(4)
  set occurTime($2.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOccurTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearOccurTime() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureOccurTime() => $_ensure(3);

  /// May be empty if no session was active.
  @$pb.TagNumber(5)
  $core.String get sessionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sessionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSessionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessionId() => $_clearField(5);

  /// System-enriched properties (geo, user-agent, etc.).
  @$pb.TagNumber(6)
  $3.Struct get autoProperties => $_getN(5);
  @$pb.TagNumber(6)
  set autoProperties($3.Struct value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAutoProperties() => $_has(5);
  @$pb.TagNumber(6)
  void clearAutoProperties() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.Struct ensureAutoProperties() => $_ensure(5);

  /// Client-supplied custom properties.
  @$pb.TagNumber(7)
  $3.Struct get customProperties => $_getN(6);
  @$pb.TagNumber(7)
  set customProperties($3.Struct value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCustomProperties() => $_has(6);
  @$pb.TagNumber(7)
  void clearCustomProperties() => $_clearField(7);
  @$pb.TagNumber(7)
  $3.Struct ensureCustomProperties() => $_ensure(6);
}

class GetActivityFeedResponse extends $pb.GeneratedMessage {
  factory GetActivityFeedResponse({
    $core.Iterable<ActivityEvent>? events,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  GetActivityFeedResponse._();

  factory GetActivityFeedResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetActivityFeedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetActivityFeedResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..pPM<ActivityEvent>(1, _omitFieldNames ? '' : 'events',
        subBuilder: ActivityEvent.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityFeedResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityFeedResponse copyWith(
          void Function(GetActivityFeedResponse) updates) =>
      super.copyWith((message) => updates(message as GetActivityFeedResponse))
          as GetActivityFeedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActivityFeedResponse create() => GetActivityFeedResponse._();
  @$core.override
  GetActivityFeedResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetActivityFeedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetActivityFeedResponse>(create);
  static GetActivityFeedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ActivityEvent> get events => $_getList(0);

  /// Empty when there are no more pages.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class GetEventExplorerRequest extends $pb.GeneratedMessage {
  factory GetEventExplorerRequest({
    $core.String? distinctId,
    $core.String? sessionId,
    $0.TimeRange? timeRange,
    $core.Iterable<$1.PropertyFilter>? propertyFilters,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$1.EventFilter>? events,
  }) {
    final result = create();
    if (distinctId != null) result.distinctId = distinctId;
    if (sessionId != null) result.sessionId = sessionId;
    if (timeRange != null) result.timeRange = timeRange;
    if (propertyFilters != null) result.propertyFilters.addAll(propertyFilters);
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (events != null) result.events.addAll(events);
    return result;
  }

  GetEventExplorerRequest._();

  factory GetEventExplorerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEventExplorerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEventExplorerRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'distinctId')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..aOM<$0.TimeRange>(3, _omitFieldNames ? '' : 'timeRange',
        subBuilder: $0.TimeRange.create)
    ..pPM<$1.PropertyFilter>(4, _omitFieldNames ? '' : 'propertyFilters',
        subBuilder: $1.PropertyFilter.create)
    ..aI(5, _omitFieldNames ? '' : 'pageSize')
    ..aOS(6, _omitFieldNames ? '' : 'pageToken')
    ..pPM<$1.EventFilter>(7, _omitFieldNames ? '' : 'events',
        subBuilder: $1.EventFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventExplorerRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventExplorerRequest copyWith(
          void Function(GetEventExplorerRequest) updates) =>
      super.copyWith((message) => updates(message as GetEventExplorerRequest))
          as GetEventExplorerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEventExplorerRequest create() => GetEventExplorerRequest._();
  @$core.override
  GetEventExplorerRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetEventExplorerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEventExplorerRequest>(create);
  static GetEventExplorerRequest? _defaultInstance;

  /// Optional. Filter to a specific user. Empty means all users.
  @$pb.TagNumber(1)
  $core.String get distinctId => $_getSZ(0);
  @$pb.TagNumber(1)
  set distinctId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDistinctId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDistinctId() => $_clearField(1);

  /// Optional. Filter by session. Empty means all sessions.
  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  /// Optional. Restrict to events within this time window.
  @$pb.TagNumber(3)
  $0.TimeRange get timeRange => $_getN(2);
  @$pb.TagNumber(3)
  set timeRange($0.TimeRange value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeRange() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeRange() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.TimeRange ensureTimeRange() => $_ensure(2);

  /// Optional. Filter by event properties (auto or custom).
  @$pb.TagNumber(4)
  $pb.PbList<$1.PropertyFilter> get propertyFilters => $_getList(3);

  /// 0 means server default (100). Max 1000.
  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);

  /// Opaque cursor from a previous response's next_page_token. Empty for the first page.
  @$pb.TagNumber(6)
  $core.String get pageToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set pageToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPageToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageToken() => $_clearField(6);

  /// Optional. Filter by multiple event types with per-event property filters.
  @$pb.TagNumber(7)
  $pb.PbList<$1.EventFilter> get events => $_getList(6);
}

class GetEventExplorerResponse extends $pb.GeneratedMessage {
  factory GetEventExplorerResponse({
    $core.Iterable<ActivityEvent>? events,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  GetEventExplorerResponse._();

  factory GetEventExplorerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEventExplorerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEventExplorerResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..pPM<ActivityEvent>(1, _omitFieldNames ? '' : 'events',
        subBuilder: ActivityEvent.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventExplorerResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventExplorerResponse copyWith(
          void Function(GetEventExplorerResponse) updates) =>
      super.copyWith((message) => updates(message as GetEventExplorerResponse))
          as GetEventExplorerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEventExplorerResponse create() => GetEventExplorerResponse._();
  @$core.override
  GetEventExplorerResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetEventExplorerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEventExplorerResponse>(create);
  static GetEventExplorerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ActivityEvent> get events => $_getList(0);

  /// Empty when there are no more pages.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class GetPropertyValuesRequest extends $pb.GeneratedMessage {
  factory GetPropertyValuesRequest({
    $core.String? propertyKey,
    $4.PropertySource? source,
    $core.String? eventKind,
  }) {
    final result = create();
    if (propertyKey != null) result.propertyKey = propertyKey;
    if (source != null) result.source = source;
    if (eventKind != null) result.eventKind = eventKind;
    return result;
  }

  GetPropertyValuesRequest._();

  factory GetPropertyValuesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPropertyValuesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPropertyValuesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'propertyKey')
    ..aE<$4.PropertySource>(2, _omitFieldNames ? '' : 'source',
        enumValues: $4.PropertySource.values)
    ..aOS(3, _omitFieldNames ? '' : 'eventKind')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPropertyValuesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPropertyValuesRequest copyWith(
          void Function(GetPropertyValuesRequest) updates) =>
      super.copyWith((message) => updates(message as GetPropertyValuesRequest))
          as GetPropertyValuesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPropertyValuesRequest create() => GetPropertyValuesRequest._();
  @$core.override
  GetPropertyValuesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetPropertyValuesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPropertyValuesRequest>(create);
  static GetPropertyValuesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get propertyKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set propertyKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPropertyKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPropertyKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $4.PropertySource get source => $_getN(1);
  @$pb.TagNumber(2)
  set source($4.PropertySource value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearSource() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get eventKind => $_getSZ(2);
  @$pb.TagNumber(3)
  set eventKind($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEventKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventKind() => $_clearField(3);
}

class GetPropertyValuesResponse extends $pb.GeneratedMessage {
  factory GetPropertyValuesResponse({
    $core.Iterable<$core.String>? values,
  }) {
    final result = create();
    if (values != null) result.values.addAll(values);
    return result;
  }

  GetPropertyValuesResponse._();

  factory GetPropertyValuesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPropertyValuesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPropertyValuesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'values')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPropertyValuesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPropertyValuesResponse copyWith(
          void Function(GetPropertyValuesResponse) updates) =>
      super.copyWith((message) => updates(message as GetPropertyValuesResponse))
          as GetPropertyValuesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPropertyValuesResponse create() => GetPropertyValuesResponse._();
  @$core.override
  GetPropertyValuesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetPropertyValuesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPropertyValuesResponse>(create);
  static GetPropertyValuesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get values => $_getList(0);
}

class GetActivityHeatmapRequest extends $pb.GeneratedMessage {
  factory GetActivityHeatmapRequest({
    $core.String? distinctId,
    $0.TimeRange? timeRange,
  }) {
    final result = create();
    if (distinctId != null) result.distinctId = distinctId;
    if (timeRange != null) result.timeRange = timeRange;
    return result;
  }

  GetActivityHeatmapRequest._();

  factory GetActivityHeatmapRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetActivityHeatmapRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetActivityHeatmapRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'distinctId')
    ..aOM<$0.TimeRange>(2, _omitFieldNames ? '' : 'timeRange',
        subBuilder: $0.TimeRange.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityHeatmapRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityHeatmapRequest copyWith(
          void Function(GetActivityHeatmapRequest) updates) =>
      super.copyWith((message) => updates(message as GetActivityHeatmapRequest))
          as GetActivityHeatmapRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActivityHeatmapRequest create() => GetActivityHeatmapRequest._();
  @$core.override
  GetActivityHeatmapRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetActivityHeatmapRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetActivityHeatmapRequest>(create);
  static GetActivityHeatmapRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get distinctId => $_getSZ(0);
  @$pb.TagNumber(1)
  set distinctId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDistinctId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDistinctId() => $_clearField(1);

  /// Optional. Defaults to the last 60 days when omitted.
  @$pb.TagNumber(2)
  $0.TimeRange get timeRange => $_getN(1);
  @$pb.TagNumber(2)
  set timeRange($0.TimeRange value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTimeRange() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeRange() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.TimeRange ensureTimeRange() => $_ensure(1);
}

/// HeatmapDay holds the event count for a single calendar day.
class HeatmapDay extends $pb.GeneratedMessage {
  factory HeatmapDay({
    $core.String? date,
    $fixnum.Int64? count,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (count != null) result.count = count;
    return result;
  }

  HeatmapDay._();

  factory HeatmapDay.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatmapDay.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatmapDay',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..aInt64(2, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatmapDay clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatmapDay copyWith(void Function(HeatmapDay) updates) =>
      super.copyWith((message) => updates(message as HeatmapDay)) as HeatmapDay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatmapDay create() => HeatmapDay._();
  @$core.override
  HeatmapDay createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeatmapDay getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatmapDay>(create);
  static HeatmapDay? _defaultInstance;

  /// Date in YYYY-MM-DD format (UTC).
  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => $_clearField(2);
}

class GetActivityHeatmapResponse extends $pb.GeneratedMessage {
  factory GetActivityHeatmapResponse({
    $core.Iterable<HeatmapDay>? days,
  }) {
    final result = create();
    if (days != null) result.days.addAll(days);
    return result;
  }

  GetActivityHeatmapResponse._();

  factory GetActivityHeatmapResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetActivityHeatmapResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetActivityHeatmapResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..pPM<HeatmapDay>(1, _omitFieldNames ? '' : 'days',
        subBuilder: HeatmapDay.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityHeatmapResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityHeatmapResponse copyWith(
          void Function(GetActivityHeatmapResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetActivityHeatmapResponse))
          as GetActivityHeatmapResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActivityHeatmapResponse create() => GetActivityHeatmapResponse._();
  @$core.override
  GetActivityHeatmapResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetActivityHeatmapResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetActivityHeatmapResponse>(create);
  static GetActivityHeatmapResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HeatmapDay> get days => $_getList(0);
}

class GetProfileStatsRequest extends $pb.GeneratedMessage {
  factory GetProfileStatsRequest({
    $core.String? distinctId,
  }) {
    final result = create();
    if (distinctId != null) result.distinctId = distinctId;
    return result;
  }

  GetProfileStatsRequest._();

  factory GetProfileStatsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProfileStatsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProfileStatsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'distinctId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileStatsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileStatsRequest copyWith(
          void Function(GetProfileStatsRequest) updates) =>
      super.copyWith((message) => updates(message as GetProfileStatsRequest))
          as GetProfileStatsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProfileStatsRequest create() => GetProfileStatsRequest._();
  @$core.override
  GetProfileStatsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetProfileStatsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProfileStatsRequest>(create);
  static GetProfileStatsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get distinctId => $_getSZ(0);
  @$pb.TagNumber(1)
  set distinctId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDistinctId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDistinctId() => $_clearField(1);
}

/// ProfileStats holds aggregate event statistics and device/location context
/// derived from the profile's latest event.
class ProfileStats extends $pb.GeneratedMessage {
  factory ProfileStats({
    $2.Timestamp? firstSeen,
    $2.Timestamp? lastSeen,
    $fixnum.Int64? totalEvents,
    $core.String? browser,
    $core.String? browserVersion,
    $core.String? os,
    $core.String? osVersion,
    $core.String? device,
    $core.String? country,
    $core.String? city,
    $core.String? ip,
  }) {
    final result = create();
    if (firstSeen != null) result.firstSeen = firstSeen;
    if (lastSeen != null) result.lastSeen = lastSeen;
    if (totalEvents != null) result.totalEvents = totalEvents;
    if (browser != null) result.browser = browser;
    if (browserVersion != null) result.browserVersion = browserVersion;
    if (os != null) result.os = os;
    if (osVersion != null) result.osVersion = osVersion;
    if (device != null) result.device = device;
    if (country != null) result.country = country;
    if (city != null) result.city = city;
    if (ip != null) result.ip = ip;
    return result;
  }

  ProfileStats._();

  factory ProfileStats.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileStats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileStats',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOM<$2.Timestamp>(1, _omitFieldNames ? '' : 'firstSeen',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(2, _omitFieldNames ? '' : 'lastSeen',
        subBuilder: $2.Timestamp.create)
    ..aInt64(3, _omitFieldNames ? '' : 'totalEvents')
    ..aOS(4, _omitFieldNames ? '' : 'browser')
    ..aOS(5, _omitFieldNames ? '' : 'browserVersion')
    ..aOS(6, _omitFieldNames ? '' : 'os')
    ..aOS(7, _omitFieldNames ? '' : 'osVersion')
    ..aOS(8, _omitFieldNames ? '' : 'device')
    ..aOS(9, _omitFieldNames ? '' : 'country')
    ..aOS(10, _omitFieldNames ? '' : 'city')
    ..aOS(11, _omitFieldNames ? '' : 'ip')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileStats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileStats copyWith(void Function(ProfileStats) updates) =>
      super.copyWith((message) => updates(message as ProfileStats))
          as ProfileStats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileStats create() => ProfileStats._();
  @$core.override
  ProfileStats createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileStats>(create);
  static ProfileStats? _defaultInstance;

  /// Timestamp of the earliest event recorded for this profile.
  @$pb.TagNumber(1)
  $2.Timestamp get firstSeen => $_getN(0);
  @$pb.TagNumber(1)
  set firstSeen($2.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstSeen() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstSeen() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Timestamp ensureFirstSeen() => $_ensure(0);

  /// Timestamp of the most recent event recorded for this profile.
  @$pb.TagNumber(2)
  $2.Timestamp get lastSeen => $_getN(1);
  @$pb.TagNumber(2)
  set lastSeen($2.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLastSeen() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastSeen() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Timestamp ensureLastSeen() => $_ensure(1);

  /// Total number of events recorded for this profile.
  @$pb.TagNumber(3)
  $fixnum.Int64 get totalEvents => $_getI64(2);
  @$pb.TagNumber(3)
  set totalEvents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalEvents() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalEvents() => $_clearField(3);

  /// Browser name from the latest event (e.g. "Chrome"). Empty if unavailable.
  @$pb.TagNumber(4)
  $core.String get browser => $_getSZ(3);
  @$pb.TagNumber(4)
  set browser($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBrowser() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrowser() => $_clearField(4);

  /// Major browser version from the latest event (e.g. "124"). Empty if unavailable.
  @$pb.TagNumber(5)
  $core.String get browserVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set browserVersion($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBrowserVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearBrowserVersion() => $_clearField(5);

  /// OS name from the latest event (e.g. "Mac OS X"). Empty if unavailable.
  @$pb.TagNumber(6)
  $core.String get os => $_getSZ(5);
  @$pb.TagNumber(6)
  set os($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOs() => $_has(5);
  @$pb.TagNumber(6)
  void clearOs() => $_clearField(6);

  /// Major OS version from the latest event (e.g. "14"). Empty if unavailable.
  @$pb.TagNumber(7)
  $core.String get osVersion => $_getSZ(6);
  @$pb.TagNumber(7)
  set osVersion($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOsVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearOsVersion() => $_clearField(7);

  /// Device model from the latest event (e.g. "iPhone"). Empty for desktop browsers.
  @$pb.TagNumber(8)
  $core.String get device => $_getSZ(7);
  @$pb.TagNumber(8)
  set device($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDevice() => $_has(7);
  @$pb.TagNumber(8)
  void clearDevice() => $_clearField(8);

  /// Country name from the latest event (e.g. "United States"). Empty if unavailable.
  @$pb.TagNumber(9)
  $core.String get country => $_getSZ(8);
  @$pb.TagNumber(9)
  set country($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCountry() => $_has(8);
  @$pb.TagNumber(9)
  void clearCountry() => $_clearField(9);

  /// City name from the latest event (e.g. "San Francisco"). Empty if unavailable.
  @$pb.TagNumber(10)
  $core.String get city => $_getSZ(9);
  @$pb.TagNumber(10)
  set city($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCity() => $_has(9);
  @$pb.TagNumber(10)
  void clearCity() => $_clearField(10);

  /// IP address from the latest event. Empty if unavailable.
  @$pb.TagNumber(11)
  $core.String get ip => $_getSZ(10);
  @$pb.TagNumber(11)
  set ip($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIp() => $_has(10);
  @$pb.TagNumber(11)
  void clearIp() => $_clearField(11);
}

class GetProfileStatsResponse extends $pb.GeneratedMessage {
  factory GetProfileStatsResponse({
    ProfileStats? stats,
    $core.Iterable<HeatmapDay>? heatmap,
    $3.Struct? properties,
  }) {
    final result = create();
    if (stats != null) result.stats = stats;
    if (heatmap != null) result.heatmap.addAll(heatmap);
    if (properties != null) result.properties = properties;
    return result;
  }

  GetProfileStatsResponse._();

  factory GetProfileStatsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProfileStatsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProfileStatsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.activity.v1'),
      createEmptyInstance: create)
    ..aOM<ProfileStats>(1, _omitFieldNames ? '' : 'stats',
        subBuilder: ProfileStats.create)
    ..pPM<HeatmapDay>(2, _omitFieldNames ? '' : 'heatmap',
        subBuilder: HeatmapDay.create)
    ..aOM<$3.Struct>(3, _omitFieldNames ? '' : 'properties',
        subBuilder: $3.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileStatsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileStatsResponse copyWith(
          void Function(GetProfileStatsResponse) updates) =>
      super.copyWith((message) => updates(message as GetProfileStatsResponse))
          as GetProfileStatsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProfileStatsResponse create() => GetProfileStatsResponse._();
  @$core.override
  GetProfileStatsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetProfileStatsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProfileStatsResponse>(create);
  static GetProfileStatsResponse? _defaultInstance;

  /// Not set when the profile has no recorded events in ClickHouse.
  @$pb.TagNumber(1)
  ProfileStats get stats => $_getN(0);
  @$pb.TagNumber(1)
  set stats(ProfileStats value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStats() => $_has(0);
  @$pb.TagNumber(1)
  void clearStats() => $_clearField(1);
  @$pb.TagNumber(1)
  ProfileStats ensureStats() => $_ensure(0);

  /// Per-day event counts for the last 60 days.
  @$pb.TagNumber(2)
  $pb.PbList<HeatmapDay> get heatmap => $_getList(1);

  /// Profile properties set via identify() calls. Includes both auto-properties
  /// (prefixed with '$') and custom properties. Not set when no profile record exists in PostgreSQL.
  @$pb.TagNumber(3)
  $3.Struct get properties => $_getN(2);
  @$pb.TagNumber(3)
  set properties($3.Struct value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProperties() => $_has(2);
  @$pb.TagNumber(3)
  void clearProperties() => $_clearField(3);
  @$pb.TagNumber(3)
  $3.Struct ensureProperties() => $_ensure(2);
}

/// ActivityService provides paginated access to raw event data and aggregated activity insights for user profiles.
class ActivityServiceApi {
  final $pb.RpcClient _client;

  ActivityServiceApi(this._client);

  /// GetActivityFeed returns a paginated, filterable list of events for a user profile.
  /// Resolves profile aliases so merged anonymous events are included.
  $async.Future<GetActivityFeedResponse> getActivityFeed(
          $pb.ClientContext? ctx, GetActivityFeedRequest request) =>
      _client.invoke<GetActivityFeedResponse>(ctx, 'ActivityService',
          'GetActivityFeed', request, GetActivityFeedResponse());

  /// GetEventExplorer returns a paginated, filterable list of events across all users
  /// in a project. Does not resolve aliases.
  $async.Future<GetEventExplorerResponse> getEventExplorer(
          $pb.ClientContext? ctx, GetEventExplorerRequest request) =>
      _client.invoke<GetEventExplorerResponse>(ctx, 'ActivityService',
          'GetEventExplorer', request, GetEventExplorerResponse());

  /// GetFilterSchema returns event names, property keys, and profile property keys for filter UIs.
  /// The filter-schema concept is service-agnostic; both shared.activity and
  /// shared.insights expose the same shape via common.v1.
  /// buf:lint:ignore RPC_REQUEST_STANDARD_NAME
  /// buf:lint:ignore RPC_RESPONSE_STANDARD_NAME
  /// buf:lint:ignore RPC_REQUEST_RESPONSE_UNIQUE
  $async.Future<$4.GetFilterSchemaResponse> getFilterSchema(
          $pb.ClientContext? ctx, $4.GetFilterSchemaRequest request) =>
      _client.invoke<$4.GetFilterSchemaResponse>(ctx, 'ActivityService',
          'GetFilterSchema', request, $4.GetFilterSchemaResponse());

  /// GetPropertyValues returns distinct values for a given property key.
  $async.Future<GetPropertyValuesResponse> getPropertyValues(
          $pb.ClientContext? ctx, GetPropertyValuesRequest request) =>
      _client.invoke<GetPropertyValuesResponse>(ctx, 'ActivityService',
          'GetPropertyValues', request, GetPropertyValuesResponse());

  /// GetActivityHeatmap returns per-day event counts for a user profile over a time window.
  /// Defaults to the last 60 days when no time_range is provided.
  $async.Future<GetActivityHeatmapResponse> getActivityHeatmap(
          $pb.ClientContext? ctx, GetActivityHeatmapRequest request) =>
      _client.invoke<GetActivityHeatmapResponse>(ctx, 'ActivityService',
          'GetActivityHeatmap', request, GetActivityHeatmapResponse());

  /// GetProfileStats returns aggregate statistics, device/browser/location context from the
  /// latest event, per-day heatmap data (last 60 days), and profile properties for a profile.
  /// Resolves aliases so merged anonymous events are included.
  $async.Future<GetProfileStatsResponse> getProfileStats(
          $pb.ClientContext? ctx, GetProfileStatsRequest request) =>
      _client.invoke<GetProfileStatsResponse>(ctx, 'ActivityService',
          'GetProfileStats', request, GetProfileStatsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
