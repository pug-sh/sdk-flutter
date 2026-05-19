// This is a generated file - do not edit.
//
// Generated from common/v1/filters.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'filter_schema.pbenum.dart' as $0;
import 'filters.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'filters.pbenum.dart';

class PropertyFilter extends $pb.GeneratedMessage {
  factory PropertyFilter({
    $core.String? property,
    FilterOperator? operator,
    $core.String? value,
    $core.Iterable<$core.String>? values,
    $0.PropertySource? source,
  }) {
    final result = create();
    if (property != null) result.property = property;
    if (operator != null) result.operator = operator;
    if (value != null) result.value = value;
    if (values != null) result.values.addAll(values);
    if (source != null) result.source = source;
    return result;
  }

  PropertyFilter._();

  factory PropertyFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PropertyFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PropertyFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'property')
    ..aE<FilterOperator>(2, _omitFieldNames ? '' : 'operator',
        enumValues: FilterOperator.values)
    ..aOS(3, _omitFieldNames ? '' : 'value')
    ..pPS(4, _omitFieldNames ? '' : 'values')
    ..aE<$0.PropertySource>(5, _omitFieldNames ? '' : 'source',
        enumValues: $0.PropertySource.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PropertyFilter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PropertyFilter copyWith(void Function(PropertyFilter) updates) =>
      super.copyWith((message) => updates(message as PropertyFilter))
          as PropertyFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PropertyFilter create() => PropertyFilter._();
  @$core.override
  PropertyFilter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PropertyFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PropertyFilter>(create);
  static PropertyFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get property => $_getSZ(0);
  @$pb.TagNumber(1)
  set property($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProperty() => $_has(0);
  @$pb.TagNumber(1)
  void clearProperty() => $_clearField(1);

  @$pb.TagNumber(2)
  FilterOperator get operator => $_getN(1);
  @$pb.TagNumber(2)
  set operator(FilterOperator value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOperator() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperator() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get value => $_getSZ(2);
  @$pb.TagNumber(3)
  set value($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get values => $_getList(3);

  @$pb.TagNumber(5)
  $0.PropertySource get source => $_getN(4);
  @$pb.TagNumber(5)
  set source($0.PropertySource value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => $_clearField(5);
}

/// EventFilter selects events by kind with optional per-event property filters.
/// Used across activity feeds, event explorer, and insights queries.
class EventFilter extends $pb.GeneratedMessage {
  factory EventFilter({
    $core.String? kind,
    $core.Iterable<PropertyFilter>? filters,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (filters != null) result.filters.addAll(filters);
    return result;
  }

  EventFilter._();

  factory EventFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..pPM<PropertyFilter>(2, _omitFieldNames ? '' : 'filters',
        subBuilder: PropertyFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventFilter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventFilter copyWith(void Function(EventFilter) updates) =>
      super.copyWith((message) => updates(message as EventFilter))
          as EventFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventFilter create() => EventFilter._();
  @$core.override
  EventFilter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventFilter>(create);
  static EventFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PropertyFilter> get filters => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
