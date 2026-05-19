// This is a generated file - do not edit.
//
// Generated from common/v1/filter_schema.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import 'filter_schema.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'filter_schema.pbenum.dart';

class EventNameMeta extends $pb.GeneratedMessage {
  factory EventNameMeta({
    $core.String? name,
    $fixnum.Int64? count,
    $0.Timestamp? lastSeenAt,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (count != null) result.count = count;
    if (lastSeenAt != null) result.lastSeenAt = lastSeenAt;
    return result;
  }

  EventNameMeta._();

  factory EventNameMeta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventNameMeta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventNameMeta',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'count', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'lastSeenAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventNameMeta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventNameMeta copyWith(void Function(EventNameMeta) updates) =>
      super.copyWith((message) => updates(message as EventNameMeta))
          as EventNameMeta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventNameMeta create() => EventNameMeta._();
  @$core.override
  EventNameMeta createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventNameMeta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventNameMeta>(create);
  static EventNameMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get lastSeenAt => $_getN(2);
  @$pb.TagNumber(3)
  set lastSeenAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLastSeenAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastSeenAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureLastSeenAt() => $_ensure(2);
}

class PropertyKeyMeta extends $pb.GeneratedMessage {
  factory PropertyKeyMeta({
    $core.String? name,
    $fixnum.Int64? count,
    $0.Timestamp? lastSeenAt,
    PropertyValueType? valueType,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (count != null) result.count = count;
    if (lastSeenAt != null) result.lastSeenAt = lastSeenAt;
    if (valueType != null) result.valueType = valueType;
    return result;
  }

  PropertyKeyMeta._();

  factory PropertyKeyMeta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PropertyKeyMeta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PropertyKeyMeta',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'count', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'lastSeenAt',
        subBuilder: $0.Timestamp.create)
    ..aE<PropertyValueType>(4, _omitFieldNames ? '' : 'valueType',
        enumValues: PropertyValueType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PropertyKeyMeta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PropertyKeyMeta copyWith(void Function(PropertyKeyMeta) updates) =>
      super.copyWith((message) => updates(message as PropertyKeyMeta))
          as PropertyKeyMeta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PropertyKeyMeta create() => PropertyKeyMeta._();
  @$core.override
  PropertyKeyMeta createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PropertyKeyMeta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PropertyKeyMeta>(create);
  static PropertyKeyMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get lastSeenAt => $_getN(2);
  @$pb.TagNumber(3)
  set lastSeenAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLastSeenAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastSeenAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureLastSeenAt() => $_ensure(2);

  /// The value_type observed at the earliest last_seen for this key
  /// (first-touch). Deterministic across calls. When values for the same key
  /// span multiple types (rare drift), this stays pinned to the first-observed
  /// type, matching the funnel/retention breakdown attribution rule.
  @$pb.TagNumber(4)
  PropertyValueType get valueType => $_getN(3);
  @$pb.TagNumber(4)
  set valueType(PropertyValueType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasValueType() => $_has(3);
  @$pb.TagNumber(4)
  void clearValueType() => $_clearField(4);
}

/// GetFilterSchemaRequest is shared by every service that exposes a
/// GetFilterSchema RPC (currently shared.activity.v1 and shared.insights.v1).
/// Keeping the request shape here avoids drift between services and is also a
/// signal that the filter-schema concept is service-agnostic.
class GetFilterSchemaRequest extends $pb.GeneratedMessage {
  factory GetFilterSchemaRequest({
    $core.String? eventKind,
    $core.Iterable<PropertyValueType>? allowedTypes,
  }) {
    final result = create();
    if (eventKind != null) result.eventKind = eventKind;
    if (allowedTypes != null) result.allowedTypes.addAll(allowedTypes);
    return result;
  }

  GetFilterSchemaRequest._();

  factory GetFilterSchemaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFilterSchemaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFilterSchemaRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventKind')
    ..pc<PropertyValueType>(
        2, _omitFieldNames ? '' : 'allowedTypes', $pb.PbFieldType.KE,
        valueOf: PropertyValueType.valueOf,
        enumValues: PropertyValueType.values,
        defaultEnumValue: PropertyValueType.PROPERTY_VALUE_TYPE_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFilterSchemaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFilterSchemaRequest copyWith(
          void Function(GetFilterSchemaRequest) updates) =>
      super.copyWith((message) => updates(message as GetFilterSchemaRequest))
          as GetFilterSchemaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFilterSchemaRequest create() => GetFilterSchemaRequest._();
  @$core.override
  GetFilterSchemaRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFilterSchemaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFilterSchemaRequest>(create);
  static GetFilterSchemaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventKind => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventKind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PropertyValueType> get allowedTypes => $_getList(1);
}

/// GetFilterSchemaResponse mirrors the shared request shape — same reason.
class GetFilterSchemaResponse extends $pb.GeneratedMessage {
  factory GetFilterSchemaResponse({
    $core.Iterable<EventNameMeta>? events,
    $core.Iterable<PropertyKeyMeta>? autoPropertyKeys,
    $core.Iterable<PropertyKeyMeta>? customPropertyKeys,
    $core.Iterable<PropertyKeyMeta>? profilePropertyKeys,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (autoPropertyKeys != null)
      result.autoPropertyKeys.addAll(autoPropertyKeys);
    if (customPropertyKeys != null)
      result.customPropertyKeys.addAll(customPropertyKeys);
    if (profilePropertyKeys != null)
      result.profilePropertyKeys.addAll(profilePropertyKeys);
    return result;
  }

  GetFilterSchemaResponse._();

  factory GetFilterSchemaResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFilterSchemaResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFilterSchemaResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..pPM<EventNameMeta>(1, _omitFieldNames ? '' : 'events',
        subBuilder: EventNameMeta.create)
    ..pPM<PropertyKeyMeta>(2, _omitFieldNames ? '' : 'autoPropertyKeys',
        subBuilder: PropertyKeyMeta.create)
    ..pPM<PropertyKeyMeta>(3, _omitFieldNames ? '' : 'customPropertyKeys',
        subBuilder: PropertyKeyMeta.create)
    ..pPM<PropertyKeyMeta>(4, _omitFieldNames ? '' : 'profilePropertyKeys',
        subBuilder: PropertyKeyMeta.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFilterSchemaResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFilterSchemaResponse copyWith(
          void Function(GetFilterSchemaResponse) updates) =>
      super.copyWith((message) => updates(message as GetFilterSchemaResponse))
          as GetFilterSchemaResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFilterSchemaResponse create() => GetFilterSchemaResponse._();
  @$core.override
  GetFilterSchemaResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFilterSchemaResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFilterSchemaResponse>(create);
  static GetFilterSchemaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EventNameMeta> get events => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<PropertyKeyMeta> get autoPropertyKeys => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<PropertyKeyMeta> get customPropertyKeys => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<PropertyKeyMeta> get profilePropertyKeys => $_getList(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
