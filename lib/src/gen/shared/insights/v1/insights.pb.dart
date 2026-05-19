// This is a generated file - do not edit.
//
// Generated from shared/insights/v1/insights.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $1;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $3;

import '../../../common/v1/filter_schema.pb.dart' as $4;
import '../../../common/v1/filters.pb.dart' as $2;
import '../../../common/v1/time.pb.dart' as $0;
import 'insights.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'insights.pbenum.dart';

class QueryRequest extends $pb.GeneratedMessage {
  factory QueryRequest({
    InsightType? insightType,
    $0.TimeRange? timeRange,
    Granularity? granularity,
    $core.Iterable<EventQuery>? events,
    $core.Iterable<Breakdown>? breakdowns,
    $core.int? breakdownLimit,
    $core.Iterable<FilterGroup>? filterGroups,
    $2.LogicalOperator? filterGroupsOperator,
    $1.Duration? conversionWindow,
    $core.bool? includeStepTiming,
  }) {
    final result = create();
    if (insightType != null) result.insightType = insightType;
    if (timeRange != null) result.timeRange = timeRange;
    if (granularity != null) result.granularity = granularity;
    if (events != null) result.events.addAll(events);
    if (breakdowns != null) result.breakdowns.addAll(breakdowns);
    if (breakdownLimit != null) result.breakdownLimit = breakdownLimit;
    if (filterGroups != null) result.filterGroups.addAll(filterGroups);
    if (filterGroupsOperator != null)
      result.filterGroupsOperator = filterGroupsOperator;
    if (conversionWindow != null) result.conversionWindow = conversionWindow;
    if (includeStepTiming != null) result.includeStepTiming = includeStepTiming;
    return result;
  }

  QueryRequest._();

  factory QueryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QueryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aE<InsightType>(1, _omitFieldNames ? '' : 'insightType',
        enumValues: InsightType.values)
    ..aOM<$0.TimeRange>(2, _omitFieldNames ? '' : 'timeRange',
        subBuilder: $0.TimeRange.create)
    ..aE<Granularity>(3, _omitFieldNames ? '' : 'granularity',
        enumValues: Granularity.values)
    ..pPM<EventQuery>(4, _omitFieldNames ? '' : 'events',
        subBuilder: EventQuery.create)
    ..pPM<Breakdown>(6, _omitFieldNames ? '' : 'breakdowns',
        subBuilder: Breakdown.create)
    ..aI(7, _omitFieldNames ? '' : 'breakdownLimit')
    ..pPM<FilterGroup>(8, _omitFieldNames ? '' : 'filterGroups',
        subBuilder: FilterGroup.create)
    ..aE<$2.LogicalOperator>(9, _omitFieldNames ? '' : 'filterGroupsOperator',
        enumValues: $2.LogicalOperator.values)
    ..aOM<$1.Duration>(10, _omitFieldNames ? '' : 'conversionWindow',
        subBuilder: $1.Duration.create)
    ..aOB(11, _omitFieldNames ? '' : 'includeStepTiming')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryRequest copyWith(void Function(QueryRequest) updates) =>
      super.copyWith((message) => updates(message as QueryRequest))
          as QueryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryRequest create() => QueryRequest._();
  @$core.override
  QueryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static QueryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryRequest>(create);
  static QueryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsightType get insightType => $_getN(0);
  @$pb.TagNumber(1)
  set insightType(InsightType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsightType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsightType() => $_clearField(1);

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

  @$pb.TagNumber(3)
  Granularity get granularity => $_getN(2);
  @$pb.TagNumber(3)
  set granularity(Granularity value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGranularity() => $_has(2);
  @$pb.TagNumber(3)
  void clearGranularity() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<EventQuery> get events => $_getList(3);

  @$pb.TagNumber(6)
  $pb.PbList<Breakdown> get breakdowns => $_getList(4);

  @$pb.TagNumber(7)
  $core.int get breakdownLimit => $_getIZ(5);
  @$pb.TagNumber(7)
  set breakdownLimit($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(7)
  $core.bool hasBreakdownLimit() => $_has(5);
  @$pb.TagNumber(7)
  void clearBreakdownLimit() => $_clearField(7);

  /// Optional grouped filters for top-level conditions.
  /// Each group combines its filters via group.operator.
  /// Groups are combined via filter_groups_operator.
  @$pb.TagNumber(8)
  $pb.PbList<FilterGroup> get filterGroups => $_getList(6);

  @$pb.TagNumber(9)
  $2.LogicalOperator get filterGroupsOperator => $_getN(7);
  @$pb.TagNumber(9)
  set filterGroupsOperator($2.LogicalOperator value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasFilterGroupsOperator() => $_has(7);
  @$pb.TagNumber(9)
  void clearFilterGroupsOperator() => $_clearField(9);

  /// Funnel conversion window. Only used for INSIGHT_TYPE_FUNNEL.
  /// The maximum time allowed from the first step to the last step per user.
  /// Absent means use the full time range as the window (no constraint).
  /// Must be a whole-second value of at least 1 second — windowFunnel only accepts
  /// integer-second windows, so sub-second precision would be silently truncated.
  @$pb.TagNumber(10)
  $1.Duration get conversionWindow => $_getN(8);
  @$pb.TagNumber(10)
  set conversionWindow($1.Duration value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasConversionWindow() => $_has(8);
  @$pb.TagNumber(10)
  void clearConversionWindow() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Duration ensureConversionWindow() => $_ensure(8);

  /// When true, funnel queries include per-step conversion-time statistics:
  /// average, median, p95, and an 8-bucket distribution histogram.
  /// Uses an array-based single-scan query that captures per-step timestamps,
  /// then computes timing in Go. When false (default), uses windowFunnel() for faster counts only.
  @$pb.TagNumber(11)
  $core.bool get includeStepTiming => $_getBF(9);
  @$pb.TagNumber(11)
  set includeStepTiming($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(11)
  $core.bool hasIncludeStepTiming() => $_has(9);
  @$pb.TagNumber(11)
  void clearIncludeStepTiming() => $_clearField(11);
}

enum QueryResponse_Result { trends, segmentation, funnel, retention, notSet }

class QueryResponse extends $pb.GeneratedMessage {
  factory QueryResponse({
    TrendsResult? trends,
    SegmentationResult? segmentation,
    FunnelResult? funnel,
    RetentionResult? retention,
  }) {
    final result = create();
    if (trends != null) result.trends = trends;
    if (segmentation != null) result.segmentation = segmentation;
    if (funnel != null) result.funnel = funnel;
    if (retention != null) result.retention = retention;
    return result;
  }

  QueryResponse._();

  factory QueryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QueryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, QueryResponse_Result>
      _QueryResponse_ResultByTag = {
    2: QueryResponse_Result.trends,
    3: QueryResponse_Result.segmentation,
    4: QueryResponse_Result.funnel,
    5: QueryResponse_Result.retention,
    0: QueryResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5])
    ..aOM<TrendsResult>(2, _omitFieldNames ? '' : 'trends',
        subBuilder: TrendsResult.create)
    ..aOM<SegmentationResult>(3, _omitFieldNames ? '' : 'segmentation',
        subBuilder: SegmentationResult.create)
    ..aOM<FunnelResult>(4, _omitFieldNames ? '' : 'funnel',
        subBuilder: FunnelResult.create)
    ..aOM<RetentionResult>(5, _omitFieldNames ? '' : 'retention',
        subBuilder: RetentionResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QueryResponse copyWith(void Function(QueryResponse) updates) =>
      super.copyWith((message) => updates(message as QueryResponse))
          as QueryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryResponse create() => QueryResponse._();
  @$core.override
  QueryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static QueryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryResponse>(create);
  static QueryResponse? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  QueryResponse_Result whichResult() =>
      _QueryResponse_ResultByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearResult() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  TrendsResult get trends => $_getN(0);
  @$pb.TagNumber(2)
  set trends(TrendsResult value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTrends() => $_has(0);
  @$pb.TagNumber(2)
  void clearTrends() => $_clearField(2);
  @$pb.TagNumber(2)
  TrendsResult ensureTrends() => $_ensure(0);

  @$pb.TagNumber(3)
  SegmentationResult get segmentation => $_getN(1);
  @$pb.TagNumber(3)
  set segmentation(SegmentationResult value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSegmentation() => $_has(1);
  @$pb.TagNumber(3)
  void clearSegmentation() => $_clearField(3);
  @$pb.TagNumber(3)
  SegmentationResult ensureSegmentation() => $_ensure(1);

  @$pb.TagNumber(4)
  FunnelResult get funnel => $_getN(2);
  @$pb.TagNumber(4)
  set funnel(FunnelResult value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFunnel() => $_has(2);
  @$pb.TagNumber(4)
  void clearFunnel() => $_clearField(4);
  @$pb.TagNumber(4)
  FunnelResult ensureFunnel() => $_ensure(2);

  @$pb.TagNumber(5)
  RetentionResult get retention => $_getN(3);
  @$pb.TagNumber(5)
  set retention(RetentionResult value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasRetention() => $_has(3);
  @$pb.TagNumber(5)
  void clearRetention() => $_clearField(5);
  @$pb.TagNumber(5)
  RetentionResult ensureRetention() => $_ensure(3);
}

class SegmentUsersRequest extends $pb.GeneratedMessage {
  factory SegmentUsersRequest({
    $0.TimeRange? timeRange,
    $core.Iterable<EventQuery>? events,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<FilterGroup>? filterGroups,
    $2.LogicalOperator? filterGroupsOperator,
  }) {
    final result = create();
    if (timeRange != null) result.timeRange = timeRange;
    if (events != null) result.events.addAll(events);
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (filterGroups != null) result.filterGroups.addAll(filterGroups);
    if (filterGroupsOperator != null)
      result.filterGroupsOperator = filterGroupsOperator;
    return result;
  }

  SegmentUsersRequest._();

  factory SegmentUsersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SegmentUsersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SegmentUsersRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOM<$0.TimeRange>(1, _omitFieldNames ? '' : 'timeRange',
        subBuilder: $0.TimeRange.create)
    ..pPM<EventQuery>(2, _omitFieldNames ? '' : 'events',
        subBuilder: EventQuery.create)
    ..aI(4, _omitFieldNames ? '' : 'pageSize')
    ..aOS(5, _omitFieldNames ? '' : 'pageToken')
    ..pPM<FilterGroup>(6, _omitFieldNames ? '' : 'filterGroups',
        subBuilder: FilterGroup.create)
    ..aE<$2.LogicalOperator>(7, _omitFieldNames ? '' : 'filterGroupsOperator',
        enumValues: $2.LogicalOperator.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SegmentUsersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SegmentUsersRequest copyWith(void Function(SegmentUsersRequest) updates) =>
      super.copyWith((message) => updates(message as SegmentUsersRequest))
          as SegmentUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SegmentUsersRequest create() => SegmentUsersRequest._();
  @$core.override
  SegmentUsersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SegmentUsersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SegmentUsersRequest>(create);
  static SegmentUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.TimeRange get timeRange => $_getN(0);
  @$pb.TagNumber(1)
  set timeRange($0.TimeRange value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeRange() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeRange() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.TimeRange ensureTimeRange() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<EventQuery> get events => $_getList(1);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(5)
  set pageToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(5)
  void clearPageToken() => $_clearField(5);

  /// Optional grouped filters for top-level conditions.
  @$pb.TagNumber(6)
  $pb.PbList<FilterGroup> get filterGroups => $_getList(4);

  @$pb.TagNumber(7)
  $2.LogicalOperator get filterGroupsOperator => $_getN(5);
  @$pb.TagNumber(7)
  set filterGroupsOperator($2.LogicalOperator value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasFilterGroupsOperator() => $_has(5);
  @$pb.TagNumber(7)
  void clearFilterGroupsOperator() => $_clearField(7);
}

class SegmentUsersResponse extends $pb.GeneratedMessage {
  factory SegmentUsersResponse({
    $core.Iterable<$core.String>? distinctIds,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (distinctIds != null) result.distinctIds.addAll(distinctIds);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  SegmentUsersResponse._();

  factory SegmentUsersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SegmentUsersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SegmentUsersResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'distinctIds')
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SegmentUsersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SegmentUsersResponse copyWith(void Function(SegmentUsersResponse) updates) =>
      super.copyWith((message) => updates(message as SegmentUsersResponse))
          as SegmentUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SegmentUsersResponse create() => SegmentUsersResponse._();
  @$core.override
  SegmentUsersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SegmentUsersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SegmentUsersResponse>(create);
  static SegmentUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get distinctIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class FilterGroup extends $pb.GeneratedMessage {
  factory FilterGroup({
    $core.Iterable<$2.PropertyFilter>? filters,
    $2.LogicalOperator? operator,
  }) {
    final result = create();
    if (filters != null) result.filters.addAll(filters);
    if (operator != null) result.operator = operator;
    return result;
  }

  FilterGroup._();

  factory FilterGroup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FilterGroup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FilterGroup',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..pPM<$2.PropertyFilter>(1, _omitFieldNames ? '' : 'filters',
        subBuilder: $2.PropertyFilter.create)
    ..aE<$2.LogicalOperator>(2, _omitFieldNames ? '' : 'operator',
        enumValues: $2.LogicalOperator.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterGroup clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FilterGroup copyWith(void Function(FilterGroup) updates) =>
      super.copyWith((message) => updates(message as FilterGroup))
          as FilterGroup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FilterGroup create() => FilterGroup._();
  @$core.override
  FilterGroup createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FilterGroup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FilterGroup>(create);
  static FilterGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$2.PropertyFilter> get filters => $_getList(0);

  @$pb.TagNumber(2)
  $2.LogicalOperator get operator => $_getN(1);
  @$pb.TagNumber(2)
  set operator($2.LogicalOperator value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOperator() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperator() => $_clearField(2);
}

class EventQuery extends $pb.GeneratedMessage {
  factory EventQuery({
    $2.EventFilter? event,
    AggregationType? aggregation,
    $core.String? aggregationProperty,
  }) {
    final result = create();
    if (event != null) result.event = event;
    if (aggregation != null) result.aggregation = aggregation;
    if (aggregationProperty != null)
      result.aggregationProperty = aggregationProperty;
    return result;
  }

  EventQuery._();

  factory EventQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventQuery',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOM<$2.EventFilter>(1, _omitFieldNames ? '' : 'event',
        subBuilder: $2.EventFilter.create)
    ..aE<AggregationType>(2, _omitFieldNames ? '' : 'aggregation',
        enumValues: AggregationType.values)
    ..aOS(3, _omitFieldNames ? '' : 'aggregationProperty')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventQuery copyWith(void Function(EventQuery) updates) =>
      super.copyWith((message) => updates(message as EventQuery)) as EventQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventQuery create() => EventQuery._();
  @$core.override
  EventQuery createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventQuery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventQuery>(create);
  static EventQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $2.EventFilter get event => $_getN(0);
  @$pb.TagNumber(1)
  set event($2.EventFilter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.EventFilter ensureEvent() => $_ensure(0);

  /// Aggregation type. Defaults to TOTAL when unspecified.
  /// Only used for trends and segmentation; ignored for funnel and retention.
  @$pb.TagNumber(2)
  AggregationType get aggregation => $_getN(1);
  @$pb.TagNumber(2)
  set aggregation(AggregationType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAggregation() => $_has(1);
  @$pb.TagNumber(2)
  void clearAggregation() => $_clearField(2);

  /// Property name to aggregate on. Required for SUM/AVG/MIN/MAX; ignored for TOTAL/UNIQUE_USERS/PER_USER_AVG.
  /// Pattern uses * (not +) because this field may be empty for count-based aggregation types.
  @$pb.TagNumber(3)
  $core.String get aggregationProperty => $_getSZ(2);
  @$pb.TagNumber(3)
  set aggregationProperty($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAggregationProperty() => $_has(2);
  @$pb.TagNumber(3)
  void clearAggregationProperty() => $_clearField(3);
}

class Breakdown extends $pb.GeneratedMessage {
  factory Breakdown({
    $core.String? property,
  }) {
    final result = create();
    if (property != null) result.property = property;
    return result;
  }

  Breakdown._();

  factory Breakdown.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Breakdown.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Breakdown',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'property')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Breakdown clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Breakdown copyWith(void Function(Breakdown) updates) =>
      super.copyWith((message) => updates(message as Breakdown)) as Breakdown;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Breakdown create() => Breakdown._();
  @$core.override
  Breakdown createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Breakdown getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Breakdown>(create);
  static Breakdown? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get property => $_getSZ(0);
  @$pb.TagNumber(1)
  set property($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProperty() => $_has(0);
  @$pb.TagNumber(1)
  void clearProperty() => $_clearField(1);
}

/// TrendsResult contains one TrendSeries per (event_kind, breakdown) combination.
class TrendsResult extends $pb.GeneratedMessage {
  factory TrendsResult({
    $core.Iterable<TrendSeries>? series,
  }) {
    final result = create();
    if (series != null) result.series.addAll(series);
    return result;
  }

  TrendsResult._();

  factory TrendsResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrendsResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrendsResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..pPM<TrendSeries>(1, _omitFieldNames ? '' : 'series',
        subBuilder: TrendSeries.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrendsResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrendsResult copyWith(void Function(TrendsResult) updates) =>
      super.copyWith((message) => updates(message as TrendsResult))
          as TrendsResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrendsResult create() => TrendsResult._();
  @$core.override
  TrendsResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrendsResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrendsResult>(create);
  static TrendsResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TrendSeries> get series => $_getList(0);
}

/// TrendSeries is a single time series for a trends insight.
class TrendSeries extends $pb.GeneratedMessage {
  factory TrendSeries({
    $core.String? eventKind,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? breakdown,
    $core.Iterable<DataPoint>? points,
  }) {
    final result = create();
    if (eventKind != null) result.eventKind = eventKind;
    if (breakdown != null) result.breakdown.addEntries(breakdown);
    if (points != null) result.points.addAll(points);
    return result;
  }

  TrendSeries._();

  factory TrendSeries.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrendSeries.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrendSeries',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventKind')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'breakdown',
        entryClassName: 'TrendSeries.BreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('shared.insights.v1'))
    ..pPM<DataPoint>(3, _omitFieldNames ? '' : 'points',
        subBuilder: DataPoint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrendSeries clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrendSeries copyWith(void Function(TrendSeries) updates) =>
      super.copyWith((message) => updates(message as TrendSeries))
          as TrendSeries;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrendSeries create() => TrendSeries._();
  @$core.override
  TrendSeries createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrendSeries getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrendSeries>(create);
  static TrendSeries? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventKind => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventKind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get breakdown => $_getMap(1);

  @$pb.TagNumber(3)
  $pb.PbList<DataPoint> get points => $_getList(2);
}

/// SegmentationResult is a single aggregate value.
class SegmentationResult extends $pb.GeneratedMessage {
  factory SegmentationResult({
    $core.double? total,
  }) {
    final result = create();
    if (total != null) result.total = total;
    return result;
  }

  SegmentationResult._();

  factory SegmentationResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SegmentationResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SegmentationResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SegmentationResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SegmentationResult copyWith(void Function(SegmentationResult) updates) =>
      super.copyWith((message) => updates(message as SegmentationResult))
          as SegmentationResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SegmentationResult create() => SegmentationResult._();
  @$core.override
  SegmentationResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SegmentationResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SegmentationResult>(create);
  static SegmentationResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get total => $_getN(0);
  @$pb.TagNumber(1)
  set total($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotal() => $_clearField(1);
}

/// FunnelResult contains one FunnelSeries per breakdown combination.
/// When no breakdown is requested, there is exactly one series with an empty breakdown map.
class FunnelResult extends $pb.GeneratedMessage {
  factory FunnelResult({
    $core.Iterable<FunnelSeries>? series,
  }) {
    final result = create();
    if (series != null) result.series.addAll(series);
    return result;
  }

  FunnelResult._();

  factory FunnelResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FunnelResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FunnelResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..pPM<FunnelSeries>(1, _omitFieldNames ? '' : 'series',
        subBuilder: FunnelSeries.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunnelResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunnelResult copyWith(void Function(FunnelResult) updates) =>
      super.copyWith((message) => updates(message as FunnelResult))
          as FunnelResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FunnelResult create() => FunnelResult._();
  @$core.override
  FunnelResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FunnelResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FunnelResult>(create);
  static FunnelResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FunnelSeries> get series => $_getList(0);
}

/// FunnelSeries groups funnel steps for a single breakdown combination.
/// Map keys are property names from the request's breakdowns list; values are the attributed breakdown values for this series.
class FunnelSeries extends $pb.GeneratedMessage {
  factory FunnelSeries({
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? breakdown,
    $core.Iterable<FunnelStep>? steps,
  }) {
    final result = create();
    if (breakdown != null) result.breakdown.addEntries(breakdown);
    if (steps != null) result.steps.addAll(steps);
    return result;
  }

  FunnelSeries._();

  factory FunnelSeries.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FunnelSeries.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FunnelSeries',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'breakdown',
        entryClassName: 'FunnelSeries.BreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('shared.insights.v1'))
    ..pPM<FunnelStep>(2, _omitFieldNames ? '' : 'steps',
        subBuilder: FunnelStep.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunnelSeries clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunnelSeries copyWith(void Function(FunnelSeries) updates) =>
      super.copyWith((message) => updates(message as FunnelSeries))
          as FunnelSeries;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FunnelSeries create() => FunnelSeries._();
  @$core.override
  FunnelSeries createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FunnelSeries getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FunnelSeries>(create);
  static FunnelSeries? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.String> get breakdown => $_getMap(0);

  @$pb.TagNumber(2)
  $pb.PbList<FunnelStep> get steps => $_getList(1);
}

/// DistributionBucket is a single histogram bucket for conversion time distribution.
class DistributionBucket extends $pb.GeneratedMessage {
  factory DistributionBucket({
    $core.String? label,
    $1.Duration? upperBound,
    $fixnum.Int64? count,
  }) {
    final result = create();
    if (label != null) result.label = label;
    if (upperBound != null) result.upperBound = upperBound;
    if (count != null) result.count = count;
    return result;
  }

  DistributionBucket._();

  factory DistributionBucket.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DistributionBucket.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DistributionBucket',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOM<$1.Duration>(2, _omitFieldNames ? '' : 'upperBound',
        subBuilder: $1.Duration.create)
    ..aInt64(3, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DistributionBucket clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DistributionBucket copyWith(void Function(DistributionBucket) updates) =>
      super.copyWith((message) => updates(message as DistributionBucket))
          as DistributionBucket;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DistributionBucket create() => DistributionBucket._();
  @$core.override
  DistributionBucket createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DistributionBucket getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DistributionBucket>(create);
  static DistributionBucket? _defaultInstance;

  /// Human-readable label, e.g. "0-30s", "30s-2m".
  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => $_clearField(1);

  /// Exclusive upper bound. Absent for the last open-ended bucket ("24h+"); use the label instead.
  @$pb.TagNumber(2)
  $1.Duration get upperBound => $_getN(1);
  @$pb.TagNumber(2)
  set upperBound($1.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUpperBound() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpperBound() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Duration ensureUpperBound() => $_ensure(1);

  /// Number of users whose conversion time fell in this bucket.
  @$pb.TagNumber(3)
  $fixnum.Int64 get count => $_getI64(2);
  @$pb.TagNumber(3)
  set count($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCount() => $_clearField(3);
}

/// StepTiming captures conversion-time statistics for a single funnel step
/// relative to the previous step. Present on every non-entry step when
/// include_step_timing is true; absent on the entry step (no previous step
/// to convert from) and when include_step_timing is false on the request.
/// When the step has zero converters, all four fields are zero-valued: the
/// scalar durations are zero and every distribution bucket has count=0.
/// Clients should consult FunnelStep.total to distinguish "no conversion"
/// (count=0) from "fast conversion" (count>0 with low p95). When present,
/// distribution always contains exactly 8 buckets in the canonical order
/// documented on each bucket's label.
class StepTiming extends $pb.GeneratedMessage {
  factory StepTiming({
    $1.Duration? avg,
    $1.Duration? median,
    $1.Duration? p95,
    $core.Iterable<DistributionBucket>? distribution,
  }) {
    final result = create();
    if (avg != null) result.avg = avg;
    if (median != null) result.median = median;
    if (p95 != null) result.p95 = p95;
    if (distribution != null) result.distribution.addAll(distribution);
    return result;
  }

  StepTiming._();

  factory StepTiming.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StepTiming.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StepTiming',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Duration>(1, _omitFieldNames ? '' : 'avg',
        subBuilder: $1.Duration.create)
    ..aOM<$1.Duration>(2, _omitFieldNames ? '' : 'median',
        subBuilder: $1.Duration.create)
    ..aOM<$1.Duration>(3, _omitFieldNames ? '' : 'p95',
        subBuilder: $1.Duration.create)
    ..pPM<DistributionBucket>(4, _omitFieldNames ? '' : 'distribution',
        subBuilder: DistributionBucket.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StepTiming clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StepTiming copyWith(void Function(StepTiming) updates) =>
      super.copyWith((message) => updates(message as StepTiming)) as StepTiming;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StepTiming create() => StepTiming._();
  @$core.override
  StepTiming createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StepTiming getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StepTiming>(create);
  static StepTiming? _defaultInstance;

  /// Average time from the previous step to this one.
  @$pb.TagNumber(1)
  $1.Duration get avg => $_getN(0);
  @$pb.TagNumber(1)
  set avg($1.Duration value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAvg() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvg() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Duration ensureAvg() => $_ensure(0);

  /// Median time from the previous step to this one.
  @$pb.TagNumber(2)
  $1.Duration get median => $_getN(1);
  @$pb.TagNumber(2)
  set median($1.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMedian() => $_has(1);
  @$pb.TagNumber(2)
  void clearMedian() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Duration ensureMedian() => $_ensure(1);

  /// 95th-percentile time from the previous step to this one.
  @$pb.TagNumber(3)
  $1.Duration get p95 => $_getN(2);
  @$pb.TagNumber(3)
  set p95($1.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasP95() => $_has(2);
  @$pb.TagNumber(3)
  void clearP95() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Duration ensureP95() => $_ensure(2);

  /// Histogram of conversion times across 8 fixed buckets in canonical order.
  /// Length is exactly 8 by contract; clients can index by position.
  @$pb.TagNumber(4)
  $pb.PbList<DistributionBucket> get distribution => $_getList(3);
}

/// FunnelStep is a single stage in a funnel.
class FunnelStep extends $pb.GeneratedMessage {
  factory FunnelStep({
    $core.String? eventKind,
    $core.double? total,
    StepTiming? timing,
  }) {
    final result = create();
    if (eventKind != null) result.eventKind = eventKind;
    if (total != null) result.total = total;
    if (timing != null) result.timing = timing;
    return result;
  }

  FunnelStep._();

  factory FunnelStep.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FunnelStep.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FunnelStep',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventKind')
    ..aD(2, _omitFieldNames ? '' : 'total')
    ..aOM<StepTiming>(3, _omitFieldNames ? '' : 'timing',
        subBuilder: StepTiming.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunnelStep clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FunnelStep copyWith(void Function(FunnelStep) updates) =>
      super.copyWith((message) => updates(message as FunnelStep)) as FunnelStep;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FunnelStep create() => FunnelStep._();
  @$core.override
  FunnelStep createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FunnelStep getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FunnelStep>(create);
  static FunnelStep? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventKind => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventKind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get total => $_getN(1);
  @$pb.TagNumber(2)
  set total($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  /// Conversion-time stats for this step. Absent for the first step (no previous
  /// step to convert from) and when include_step_timing is false on the request.
  @$pb.TagNumber(3)
  StepTiming get timing => $_getN(2);
  @$pb.TagNumber(3)
  set timing(StepTiming value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTiming() => $_has(2);
  @$pb.TagNumber(3)
  void clearTiming() => $_clearField(3);
  @$pb.TagNumber(3)
  StepTiming ensureTiming() => $_ensure(2);
}

/// RetentionResult contains one RetentionSeries per breakdown combination.
/// When no breakdown is requested, there is exactly one series with an empty breakdown map.
class RetentionResult extends $pb.GeneratedMessage {
  factory RetentionResult({
    $core.Iterable<RetentionSeries>? series,
  }) {
    final result = create();
    if (series != null) result.series.addAll(series);
    return result;
  }

  RetentionResult._();

  factory RetentionResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetentionResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetentionResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..pPM<RetentionSeries>(1, _omitFieldNames ? '' : 'series',
        subBuilder: RetentionSeries.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetentionResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetentionResult copyWith(void Function(RetentionResult) updates) =>
      super.copyWith((message) => updates(message as RetentionResult))
          as RetentionResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetentionResult create() => RetentionResult._();
  @$core.override
  RetentionResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RetentionResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetentionResult>(create);
  static RetentionResult? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RetentionSeries> get series => $_getList(0);
}

/// RetentionSeries groups retention cohorts for a single breakdown combination.
/// Map keys are property names from the request's breakdowns list; values are the attributed breakdown values for this series.
class RetentionSeries extends $pb.GeneratedMessage {
  factory RetentionSeries({
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? breakdown,
    $core.Iterable<RetentionCohort>? cohorts,
  }) {
    final result = create();
    if (breakdown != null) result.breakdown.addEntries(breakdown);
    if (cohorts != null) result.cohorts.addAll(cohorts);
    return result;
  }

  RetentionSeries._();

  factory RetentionSeries.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetentionSeries.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetentionSeries',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'breakdown',
        entryClassName: 'RetentionSeries.BreakdownEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('shared.insights.v1'))
    ..pPM<RetentionCohort>(2, _omitFieldNames ? '' : 'cohorts',
        subBuilder: RetentionCohort.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetentionSeries clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetentionSeries copyWith(void Function(RetentionSeries) updates) =>
      super.copyWith((message) => updates(message as RetentionSeries))
          as RetentionSeries;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetentionSeries create() => RetentionSeries._();
  @$core.override
  RetentionSeries createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RetentionSeries getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetentionSeries>(create);
  static RetentionSeries? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.String> get breakdown => $_getMap(0);

  @$pb.TagNumber(2)
  $pb.PbList<RetentionCohort> get cohorts => $_getList(1);
}

/// RetentionCohort is a single cohort's retention data.
class RetentionCohort extends $pb.GeneratedMessage {
  factory RetentionCohort({
    $core.String? cohort,
    $core.double? cohortSize,
    $core.Iterable<DataPoint>? points,
  }) {
    final result = create();
    if (cohort != null) result.cohort = cohort;
    if (cohortSize != null) result.cohortSize = cohortSize;
    if (points != null) result.points.addAll(points);
    return result;
  }

  RetentionCohort._();

  factory RetentionCohort.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetentionCohort.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetentionCohort',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cohort')
    ..aD(2, _omitFieldNames ? '' : 'cohortSize')
    ..pPM<DataPoint>(3, _omitFieldNames ? '' : 'points',
        subBuilder: DataPoint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetentionCohort clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetentionCohort copyWith(void Function(RetentionCohort) updates) =>
      super.copyWith((message) => updates(message as RetentionCohort))
          as RetentionCohort;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetentionCohort create() => RetentionCohort._();
  @$core.override
  RetentionCohort createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RetentionCohort getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetentionCohort>(create);
  static RetentionCohort? _defaultInstance;

  /// Cohort bucket timestamp (RFC3339).
  @$pb.TagNumber(1)
  $core.String get cohort => $_getSZ(0);
  @$pb.TagNumber(1)
  set cohort($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCohort() => $_has(0);
  @$pb.TagNumber(1)
  void clearCohort() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get cohortSize => $_getN(1);
  @$pb.TagNumber(2)
  set cohortSize($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCohortSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearCohortSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<DataPoint> get points => $_getList(2);
}

class DataPoint extends $pb.GeneratedMessage {
  factory DataPoint({
    $3.Timestamp? time,
    $core.double? value,
  }) {
    final result = create();
    if (time != null) result.time = time;
    if (value != null) result.value = value;
    return result;
  }

  DataPoint._();

  factory DataPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataPoint',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
      createEmptyInstance: create)
    ..aOM<$3.Timestamp>(1, _omitFieldNames ? '' : 'time',
        subBuilder: $3.Timestamp.create)
    ..aD(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPoint copyWith(void Function(DataPoint) updates) =>
      super.copyWith((message) => updates(message as DataPoint)) as DataPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataPoint create() => DataPoint._();
  @$core.override
  DataPoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataPoint getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DataPoint>(create);
  static DataPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Timestamp get time => $_getN(0);
  @$pb.TagNumber(1)
  set time($3.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Timestamp ensureTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
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
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
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
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.insights.v1'),
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

class InsightsServiceApi {
  final $pb.RpcClient _client;

  InsightsServiceApi(this._client);

  $async.Future<QueryResponse> query(
          $pb.ClientContext? ctx, QueryRequest request) =>
      _client.invoke<QueryResponse>(
          ctx, 'InsightsService', 'Query', request, QueryResponse());
  $async.Future<SegmentUsersResponse> segmentUsers(
          $pb.ClientContext? ctx, SegmentUsersRequest request) =>
      _client.invoke<SegmentUsersResponse>(ctx, 'InsightsService',
          'SegmentUsers', request, SegmentUsersResponse());

  /// The filter-schema concept is service-agnostic; both shared.insights and
  /// shared.activity expose the same shape via common.v1.
  /// buf:lint:ignore RPC_REQUEST_STANDARD_NAME
  /// buf:lint:ignore RPC_RESPONSE_STANDARD_NAME
  /// buf:lint:ignore RPC_REQUEST_RESPONSE_UNIQUE
  $async.Future<$4.GetFilterSchemaResponse> getFilterSchema(
          $pb.ClientContext? ctx, $4.GetFilterSchemaRequest request) =>
      _client.invoke<$4.GetFilterSchemaResponse>(ctx, 'InsightsService',
          'GetFilterSchema', request, $4.GetFilterSchemaResponse());
  $async.Future<GetPropertyValuesResponse> getPropertyValues(
          $pb.ClientContext? ctx, GetPropertyValuesRequest request) =>
      _client.invoke<GetPropertyValuesResponse>(ctx, 'InsightsService',
          'GetPropertyValues', request, GetPropertyValuesResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
