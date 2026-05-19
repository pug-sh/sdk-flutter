// This is a generated file - do not edit.
//
// Generated from shared/profiles/v1/profiles.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $2;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

import '../../../common/v1/filters.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeleteRequest extends $pb.GeneratedMessage {
  factory DeleteRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteRequest._();

  factory DeleteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRequest copyWith(void Function(DeleteRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteRequest))
          as DeleteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRequest create() => DeleteRequest._();
  @$core.override
  DeleteRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRequest>(create);
  static DeleteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class DeleteResponse extends $pb.GeneratedMessage {
  factory DeleteResponse() => create();

  DeleteResponse._();

  factory DeleteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteResponse copyWith(void Function(DeleteResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteResponse))
          as DeleteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteResponse create() => DeleteResponse._();
  @$core.override
  DeleteResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteResponse>(create);
  static DeleteResponse? _defaultInstance;
}

class GetByExternalIdRequest extends $pb.GeneratedMessage {
  factory GetByExternalIdRequest({
    $core.String? externalId,
  }) {
    final result = create();
    if (externalId != null) result.externalId = externalId;
    return result;
  }

  GetByExternalIdRequest._();

  factory GetByExternalIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetByExternalIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetByExternalIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'externalId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetByExternalIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetByExternalIdRequest copyWith(
          void Function(GetByExternalIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetByExternalIdRequest))
          as GetByExternalIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetByExternalIdRequest create() => GetByExternalIdRequest._();
  @$core.override
  GetByExternalIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetByExternalIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetByExternalIdRequest>(create);
  static GetByExternalIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get externalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set externalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExternalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExternalId() => $_clearField(1);
}

class GetByExternalIdResponse extends $pb.GeneratedMessage {
  factory GetByExternalIdResponse({
    Profile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  GetByExternalIdResponse._();

  factory GetByExternalIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetByExternalIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetByExternalIdResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOM<Profile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: Profile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetByExternalIdResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetByExternalIdResponse copyWith(
          void Function(GetByExternalIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetByExternalIdResponse))
          as GetByExternalIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetByExternalIdResponse create() => GetByExternalIdResponse._();
  @$core.override
  GetByExternalIdResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetByExternalIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetByExternalIdResponse>(create);
  static GetByExternalIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Profile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(Profile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  Profile ensureProfile() => $_ensure(0);
}

class GetRequest extends $pb.GeneratedMessage {
  factory GetRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetRequest._();

  factory GetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRequest copyWith(void Function(GetRequest) updates) =>
      super.copyWith((message) => updates(message as GetRequest)) as GetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRequest create() => GetRequest._();
  @$core.override
  GetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRequest>(create);
  static GetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetResponse extends $pb.GeneratedMessage {
  factory GetResponse({
    Profile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  GetResponse._();

  factory GetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOM<Profile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: Profile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetResponse copyWith(void Function(GetResponse) updates) =>
      super.copyWith((message) => updates(message as GetResponse))
          as GetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetResponse create() => GetResponse._();
  @$core.override
  GetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetResponse>(create);
  static GetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Profile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(Profile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  Profile ensureProfile() => $_ensure(0);
}

class FilterGroup extends $pb.GeneratedMessage {
  factory FilterGroup({
    $core.Iterable<$0.PropertyFilter>? filters,
    $0.LogicalOperator? operator,
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
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..pPM<$0.PropertyFilter>(1, _omitFieldNames ? '' : 'filters',
        subBuilder: $0.PropertyFilter.create)
    ..aE<$0.LogicalOperator>(2, _omitFieldNames ? '' : 'operator',
        enumValues: $0.LogicalOperator.values)
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
  $pb.PbList<$0.PropertyFilter> get filters => $_getList(0);

  @$pb.TagNumber(2)
  $0.LogicalOperator get operator => $_getN(1);
  @$pb.TagNumber(2)
  set operator($0.LogicalOperator value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOperator() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperator() => $_clearField(2);
}

class ListRequest extends $pb.GeneratedMessage {
  factory ListRequest({
    $core.String? pageToken,
    $core.Iterable<FilterGroup>? filterGroups,
    $0.LogicalOperator? filterGroupsOperator,
  }) {
    final result = create();
    if (pageToken != null) result.pageToken = pageToken;
    if (filterGroups != null) result.filterGroups.addAll(filterGroups);
    if (filterGroupsOperator != null)
      result.filterGroupsOperator = filterGroupsOperator;
    return result;
  }

  ListRequest._();

  factory ListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pageToken')
    ..pPM<FilterGroup>(2, _omitFieldNames ? '' : 'filterGroups',
        subBuilder: FilterGroup.create)
    ..aE<$0.LogicalOperator>(3, _omitFieldNames ? '' : 'filterGroupsOperator',
        enumValues: $0.LogicalOperator.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRequest copyWith(void Function(ListRequest) updates) =>
      super.copyWith((message) => updates(message as ListRequest))
          as ListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRequest create() => ListRequest._();
  @$core.override
  ListRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRequest>(create);
  static ListRequest? _defaultInstance;

  /// Opaque cursor from a previous response's next_page_token. Empty for the first page.
  @$pb.TagNumber(1)
  $core.String get pageToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set pageToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<FilterGroup> get filterGroups => $_getList(1);

  @$pb.TagNumber(3)
  $0.LogicalOperator get filterGroupsOperator => $_getN(2);
  @$pb.TagNumber(3)
  set filterGroupsOperator($0.LogicalOperator value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFilterGroupsOperator() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilterGroupsOperator() => $_clearField(3);
}

class ListResponse extends $pb.GeneratedMessage {
  factory ListResponse({
    $core.Iterable<Profile>? profiles,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (profiles != null) result.profiles.addAll(profiles);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListResponse._();

  factory ListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..pPM<Profile>(1, _omitFieldNames ? '' : 'profiles',
        subBuilder: Profile.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListResponse copyWith(void Function(ListResponse) updates) =>
      super.copyWith((message) => updates(message as ListResponse))
          as ListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListResponse create() => ListResponse._();
  @$core.override
  ListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListResponse>(create);
  static ListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Profile> get profiles => $_getList(0);

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

class ProfileActivitySummary extends $pb.GeneratedMessage {
  factory ProfileActivitySummary({
    $1.Timestamp? firstSeen,
    $1.Timestamp? lastSeen,
    $fixnum.Int64? totalEvents,
    $fixnum.Int64? pageviews,
    $fixnum.Int64? sessions,
    $core.String? browser,
    $core.String? browserVersion,
    $core.String? os,
    $core.String? osVersion,
    $core.String? device,
    $core.String? country,
    $core.String? region,
    $core.String? city,
  }) {
    final result = create();
    if (firstSeen != null) result.firstSeen = firstSeen;
    if (lastSeen != null) result.lastSeen = lastSeen;
    if (totalEvents != null) result.totalEvents = totalEvents;
    if (pageviews != null) result.pageviews = pageviews;
    if (sessions != null) result.sessions = sessions;
    if (browser != null) result.browser = browser;
    if (browserVersion != null) result.browserVersion = browserVersion;
    if (os != null) result.os = os;
    if (osVersion != null) result.osVersion = osVersion;
    if (device != null) result.device = device;
    if (country != null) result.country = country;
    if (region != null) result.region = region;
    if (city != null) result.city = city;
    return result;
  }

  ProfileActivitySummary._();

  factory ProfileActivitySummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileActivitySummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileActivitySummary',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'firstSeen',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'lastSeen',
        subBuilder: $1.Timestamp.create)
    ..aInt64(3, _omitFieldNames ? '' : 'totalEvents')
    ..aInt64(4, _omitFieldNames ? '' : 'pageviews')
    ..aInt64(5, _omitFieldNames ? '' : 'sessions')
    ..aOS(6, _omitFieldNames ? '' : 'browser')
    ..aOS(7, _omitFieldNames ? '' : 'browserVersion')
    ..aOS(8, _omitFieldNames ? '' : 'os')
    ..aOS(9, _omitFieldNames ? '' : 'osVersion')
    ..aOS(10, _omitFieldNames ? '' : 'device')
    ..aOS(11, _omitFieldNames ? '' : 'country')
    ..aOS(12, _omitFieldNames ? '' : 'region')
    ..aOS(13, _omitFieldNames ? '' : 'city')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileActivitySummary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileActivitySummary copyWith(
          void Function(ProfileActivitySummary) updates) =>
      super.copyWith((message) => updates(message as ProfileActivitySummary))
          as ProfileActivitySummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileActivitySummary create() => ProfileActivitySummary._();
  @$core.override
  ProfileActivitySummary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileActivitySummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileActivitySummary>(create);
  static ProfileActivitySummary? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get firstSeen => $_getN(0);
  @$pb.TagNumber(1)
  set firstSeen($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstSeen() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstSeen() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureFirstSeen() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get lastSeen => $_getN(1);
  @$pb.TagNumber(2)
  set lastSeen($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLastSeen() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastSeen() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureLastSeen() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalEvents => $_getI64(2);
  @$pb.TagNumber(3)
  set totalEvents($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalEvents() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalEvents() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get pageviews => $_getI64(3);
  @$pb.TagNumber(4)
  set pageviews($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageviews() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageviews() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get sessions => $_getI64(4);
  @$pb.TagNumber(5)
  set sessions($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSessions() => $_has(4);
  @$pb.TagNumber(5)
  void clearSessions() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get browser => $_getSZ(5);
  @$pb.TagNumber(6)
  set browser($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBrowser() => $_has(5);
  @$pb.TagNumber(6)
  void clearBrowser() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get browserVersion => $_getSZ(6);
  @$pb.TagNumber(7)
  set browserVersion($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBrowserVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrowserVersion() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get os => $_getSZ(7);
  @$pb.TagNumber(8)
  set os($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOs() => $_has(7);
  @$pb.TagNumber(8)
  void clearOs() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get osVersion => $_getSZ(8);
  @$pb.TagNumber(9)
  set osVersion($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasOsVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearOsVersion() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get device => $_getSZ(9);
  @$pb.TagNumber(10)
  set device($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDevice() => $_has(9);
  @$pb.TagNumber(10)
  void clearDevice() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get country => $_getSZ(10);
  @$pb.TagNumber(11)
  set country($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCountry() => $_has(10);
  @$pb.TagNumber(11)
  void clearCountry() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get region => $_getSZ(11);
  @$pb.TagNumber(12)
  set region($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasRegion() => $_has(11);
  @$pb.TagNumber(12)
  void clearRegion() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get city => $_getSZ(12);
  @$pb.TagNumber(13)
  set city($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCity() => $_has(12);
  @$pb.TagNumber(13)
  void clearCity() => $_clearField(13);
}

class Profile extends $pb.GeneratedMessage {
  factory Profile({
    $1.Timestamp? createTime,
    $core.String? externalId,
    $core.String? id,
    $2.Struct? properties,
    $core.String? projectId,
    $1.Timestamp? updateTime,
    ProfileActivitySummary? activity,
  }) {
    final result = create();
    if (createTime != null) result.createTime = createTime;
    if (externalId != null) result.externalId = externalId;
    if (id != null) result.id = id;
    if (properties != null) result.properties = properties;
    if (projectId != null) result.projectId = projectId;
    if (updateTime != null) result.updateTime = updateTime;
    if (activity != null) result.activity = activity;
    return result;
  }

  Profile._();

  factory Profile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Profile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Profile',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.profiles.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'createTime',
        subBuilder: $1.Timestamp.create)
    ..aOS(2, _omitFieldNames ? '' : 'externalId')
    ..aOS(3, _omitFieldNames ? '' : 'id')
    ..aOM<$2.Struct>(4, _omitFieldNames ? '' : 'properties',
        subBuilder: $2.Struct.create)
    ..aOS(5, _omitFieldNames ? '' : 'projectId')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $1.Timestamp.create)
    ..aOM<ProfileActivitySummary>(7, _omitFieldNames ? '' : 'activity',
        subBuilder: ProfileActivitySummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Profile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Profile copyWith(void Function(Profile) updates) =>
      super.copyWith((message) => updates(message as Profile)) as Profile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Profile create() => Profile._();
  @$core.override
  Profile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Profile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Profile>(create);
  static Profile? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get createTime => $_getN(0);
  @$pb.TagNumber(1)
  set createTime($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCreateTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreateTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureCreateTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get externalId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(3)
  set id($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.Struct get properties => $_getN(3);
  @$pb.TagNumber(4)
  set properties($2.Struct value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasProperties() => $_has(3);
  @$pb.TagNumber(4)
  void clearProperties() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Struct ensureProperties() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get projectId => $_getSZ(4);
  @$pb.TagNumber(5)
  set projectId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProjectId() => $_has(4);
  @$pb.TagNumber(5)
  void clearProjectId() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get updateTime => $_getN(5);
  @$pb.TagNumber(6)
  set updateTime($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdateTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureUpdateTime() => $_ensure(5);

  @$pb.TagNumber(7)
  ProfileActivitySummary get activity => $_getN(6);
  @$pb.TagNumber(7)
  set activity(ProfileActivitySummary value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasActivity() => $_has(6);
  @$pb.TagNumber(7)
  void clearActivity() => $_clearField(7);
  @$pb.TagNumber(7)
  ProfileActivitySummary ensureActivity() => $_ensure(6);
}

class ProfilesServiceApi {
  final $pb.RpcClient _client;

  ProfilesServiceApi(this._client);

  $async.Future<GetResponse> get($pb.ClientContext? ctx, GetRequest request) =>
      _client.invoke<GetResponse>(
          ctx, 'ProfilesService', 'Get', request, GetResponse());
  $async.Future<GetByExternalIdResponse> getByExternalId(
          $pb.ClientContext? ctx, GetByExternalIdRequest request) =>
      _client.invoke<GetByExternalIdResponse>(ctx, 'ProfilesService',
          'GetByExternalId', request, GetByExternalIdResponse());
  $async.Future<ListResponse> list(
          $pb.ClientContext? ctx, ListRequest request) =>
      _client.invoke<ListResponse>(
          ctx, 'ProfilesService', 'List', request, ListResponse());
  $async.Future<DeleteResponse> delete(
          $pb.ClientContext? ctx, DeleteRequest request) =>
      _client.invoke<DeleteResponse>(
          ctx, 'ProfilesService', 'Delete', request, DeleteResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
