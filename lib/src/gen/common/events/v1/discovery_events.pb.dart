// This is a generated file - do not edit.
//
// Generated from common/events/v1/discovery_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SearchProperties extends $pb.GeneratedMessage {
  factory SearchProperties({
    $core.String? query,
  }) {
    final result = create();
    if (query != null) result.query = query;
    return result;
  }

  SearchProperties._();

  factory SearchProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchProperties copyWith(void Function(SearchProperties) updates) =>
      super.copyWith((message) => updates(message as SearchProperties))
          as SearchProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchProperties create() => SearchProperties._();
  @$core.override
  SearchProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchProperties>(create);
  static SearchProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);
}

class SearchResultClickedProperties extends $pb.GeneratedMessage {
  factory SearchResultClickedProperties({
    $core.String? query,
    $core.String? resultId,
    $core.int? index,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (resultId != null) result.resultId = resultId;
    if (index != null) result.index = index;
    return result;
  }

  SearchResultClickedProperties._();

  factory SearchResultClickedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchResultClickedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchResultClickedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'resultId')
    ..aI(3, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResultClickedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchResultClickedProperties copyWith(
          void Function(SearchResultClickedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SearchResultClickedProperties))
          as SearchResultClickedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchResultClickedProperties create() =>
      SearchResultClickedProperties._();
  @$core.override
  SearchResultClickedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchResultClickedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchResultClickedProperties>(create);
  static SearchResultClickedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get resultId => $_getSZ(1);
  @$pb.TagNumber(2)
  set resultId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResultId() => $_has(1);
  @$pb.TagNumber(2)
  void clearResultId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get index => $_getIZ(2);
  @$pb.TagNumber(3)
  set index($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndex() => $_clearField(3);
}

class RecommendationViewedProperties extends $pb.GeneratedMessage {
  factory RecommendationViewedProperties({
    $core.String? recommendationId,
    $core.String? itemId,
    $core.String? source,
    $core.int? index,
  }) {
    final result = create();
    if (recommendationId != null) result.recommendationId = recommendationId;
    if (itemId != null) result.itemId = itemId;
    if (source != null) result.source = source;
    if (index != null) result.index = index;
    return result;
  }

  RecommendationViewedProperties._();

  factory RecommendationViewedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecommendationViewedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecommendationViewedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recommendationId')
    ..aOS(2, _omitFieldNames ? '' : 'itemId')
    ..aOS(3, _omitFieldNames ? '' : 'source')
    ..aI(4, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationViewedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationViewedProperties copyWith(
          void Function(RecommendationViewedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as RecommendationViewedProperties))
          as RecommendationViewedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecommendationViewedProperties create() =>
      RecommendationViewedProperties._();
  @$core.override
  RecommendationViewedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecommendationViewedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecommendationViewedProperties>(create);
  static RecommendationViewedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recommendationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recommendationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecommendationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecommendationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get source => $_getSZ(2);
  @$pb.TagNumber(3)
  set source($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearSource() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get index => $_getIZ(3);
  @$pb.TagNumber(4)
  set index($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearIndex() => $_clearField(4);
}

class RecommendationClickedProperties extends $pb.GeneratedMessage {
  factory RecommendationClickedProperties({
    $core.String? recommendationId,
    $core.String? itemId,
    $core.String? source,
    $core.int? index,
  }) {
    final result = create();
    if (recommendationId != null) result.recommendationId = recommendationId;
    if (itemId != null) result.itemId = itemId;
    if (source != null) result.source = source;
    if (index != null) result.index = index;
    return result;
  }

  RecommendationClickedProperties._();

  factory RecommendationClickedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecommendationClickedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecommendationClickedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recommendationId')
    ..aOS(2, _omitFieldNames ? '' : 'itemId')
    ..aOS(3, _omitFieldNames ? '' : 'source')
    ..aI(4, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationClickedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecommendationClickedProperties copyWith(
          void Function(RecommendationClickedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as RecommendationClickedProperties))
          as RecommendationClickedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecommendationClickedProperties create() =>
      RecommendationClickedProperties._();
  @$core.override
  RecommendationClickedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecommendationClickedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecommendationClickedProperties>(
          create);
  static RecommendationClickedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recommendationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recommendationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecommendationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecommendationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get source => $_getSZ(2);
  @$pb.TagNumber(3)
  set source($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearSource() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get index => $_getIZ(3);
  @$pb.TagNumber(4)
  set index($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearIndex() => $_clearField(4);
}

class FilterAppliedProperties extends $pb.GeneratedMessage {
  factory FilterAppliedProperties({
    $core.String? key,
    $core.String? value,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    return result;
  }

  FilterAppliedProperties._();

  factory FilterAppliedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterAppliedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterAppliedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterAppliedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterAppliedProperties copyWith(
          void Function(FilterAppliedProperties) updates) =>
      super.copyWith((message) => updates(message as FilterAppliedProperties))
          as FilterAppliedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterAppliedProperties create() => FilterAppliedProperties._();
  @$core.override
  FilterAppliedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FilterAppliedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FilterAppliedProperties>(create);
  static FilterAppliedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class SortChangedProperties extends $pb.GeneratedMessage {
  factory SortChangedProperties({
    $core.String? key,
    $core.String? direction,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (direction != null) result.direction = direction;
    return result;
  }

  SortChangedProperties._();

  factory SortChangedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SortChangedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SortChangedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'direction')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SortChangedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SortChangedProperties copyWith(
          void Function(SortChangedProperties) updates) =>
      super.copyWith((message) => updates(message as SortChangedProperties))
          as SortChangedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SortChangedProperties create() => SortChangedProperties._();
  @$core.override
  SortChangedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SortChangedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SortChangedProperties>(create);
  static SortChangedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get direction => $_getSZ(1);
  @$pb.TagNumber(2)
  set direction($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDirection() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirection() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
