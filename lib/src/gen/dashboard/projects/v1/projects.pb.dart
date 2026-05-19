// This is a generated file - do not edit.
//
// Generated from dashboard/projects/v1/projects.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class BatchGetRequest extends $pb.GeneratedMessage {
  factory BatchGetRequest({
    $core.String? orgId,
  }) {
    final result = create();
    if (orgId != null) result.orgId = orgId;
    return result;
  }

  BatchGetRequest._();

  factory BatchGetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchGetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchGetRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orgId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetRequest copyWith(void Function(BatchGetRequest) updates) =>
      super.copyWith((message) => updates(message as BatchGetRequest))
          as BatchGetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetRequest create() => BatchGetRequest._();
  @$core.override
  BatchGetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchGetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchGetRequest>(create);
  static BatchGetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orgId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orgId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrgId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrgId() => $_clearField(1);
}

class BatchGetResponse extends $pb.GeneratedMessage {
  factory BatchGetResponse({
    $core.Iterable<Project>? projects,
  }) {
    final result = create();
    if (projects != null) result.projects.addAll(projects);
    return result;
  }

  BatchGetResponse._();

  factory BatchGetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchGetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchGetResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..pPM<Project>(1, _omitFieldNames ? '' : 'projects',
        subBuilder: Project.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchGetResponse copyWith(void Function(BatchGetResponse) updates) =>
      super.copyWith((message) => updates(message as BatchGetResponse))
          as BatchGetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetResponse create() => BatchGetResponse._();
  @$core.override
  BatchGetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchGetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchGetResponse>(create);
  static BatchGetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Project> get projects => $_getList(0);
}

class CreateRequest extends $pb.GeneratedMessage {
  factory CreateRequest({
    $core.String? displayName,
    $core.String? orgId,
  }) {
    final result = create();
    if (displayName != null) result.displayName = displayName;
    if (orgId != null) result.orgId = orgId;
    return result;
  }

  CreateRequest._();

  factory CreateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'displayName')
    ..aOS(2, _omitFieldNames ? '' : 'orgId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRequest copyWith(void Function(CreateRequest) updates) =>
      super.copyWith((message) => updates(message as CreateRequest))
          as CreateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRequest create() => CreateRequest._();
  @$core.override
  CreateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRequest>(create);
  static CreateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get orgId => $_getSZ(1);
  @$pb.TagNumber(2)
  set orgId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrgId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrgId() => $_clearField(2);
}

class CreateResponse extends $pb.GeneratedMessage {
  factory CreateResponse({
    Project? project,
  }) {
    final result = create();
    if (project != null) result.project = project;
    return result;
  }

  CreateResponse._();

  factory CreateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOM<Project>(1, _omitFieldNames ? '' : 'project',
        subBuilder: Project.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateResponse copyWith(void Function(CreateResponse) updates) =>
      super.copyWith((message) => updates(message as CreateResponse))
          as CreateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateResponse create() => CreateResponse._();
  @$core.override
  CreateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateResponse>(create);
  static CreateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Project get project => $_getN(0);
  @$pb.TagNumber(1)
  set project(Project value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProject() => $_has(0);
  @$pb.TagNumber(1)
  void clearProject() => $_clearField(1);
  @$pb.TagNumber(1)
  Project ensureProject() => $_ensure(0);
}

class DeleteRequest extends $pb.GeneratedMessage {
  factory DeleteRequest() => create();

  DeleteRequest._();

  factory DeleteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
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
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
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

class GetRequest extends $pb.GeneratedMessage {
  factory GetRequest() => create();

  GetRequest._();

  factory GetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
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
}

class GetResponse extends $pb.GeneratedMessage {
  factory GetResponse({
    Project? project,
  }) {
    final result = create();
    if (project != null) result.project = project;
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
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOM<Project>(1, _omitFieldNames ? '' : 'project',
        subBuilder: Project.create)
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
  Project get project => $_getN(0);
  @$pb.TagNumber(1)
  set project(Project value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProject() => $_has(0);
  @$pb.TagNumber(1)
  void clearProject() => $_clearField(1);
  @$pb.TagNumber(1)
  Project ensureProject() => $_ensure(0);
}

class Project extends $pb.GeneratedMessage {
  factory Project({
    $core.String? displayName,
    $core.String? fcmServiceJson,
    $core.String? id,
    $core.String? orgId,
    $core.String? privateApiKey,
    $core.String? publicApiKey,
  }) {
    final result = create();
    if (displayName != null) result.displayName = displayName;
    if (fcmServiceJson != null) result.fcmServiceJson = fcmServiceJson;
    if (id != null) result.id = id;
    if (orgId != null) result.orgId = orgId;
    if (privateApiKey != null) result.privateApiKey = privateApiKey;
    if (publicApiKey != null) result.publicApiKey = publicApiKey;
    return result;
  }

  Project._();

  factory Project.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Project.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Project',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'displayName')
    ..aOS(2, _omitFieldNames ? '' : 'fcmServiceJson')
    ..aOS(3, _omitFieldNames ? '' : 'id')
    ..aOS(4, _omitFieldNames ? '' : 'orgId')
    ..aOS(5, _omitFieldNames ? '' : 'privateApiKey')
    ..aOS(6, _omitFieldNames ? '' : 'publicApiKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Project clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Project copyWith(void Function(Project) updates) =>
      super.copyWith((message) => updates(message as Project)) as Project;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Project create() => Project._();
  @$core.override
  Project createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Project getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Project>(create);
  static Project? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fcmServiceJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set fcmServiceJson($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFcmServiceJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearFcmServiceJson() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(3)
  set id($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get orgId => $_getSZ(3);
  @$pb.TagNumber(4)
  set orgId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrgId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrgId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get privateApiKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set privateApiKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPrivateApiKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearPrivateApiKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get publicApiKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set publicApiKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPublicApiKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearPublicApiKey() => $_clearField(6);
}

class UpdateDisplayNameRequest extends $pb.GeneratedMessage {
  factory UpdateDisplayNameRequest({
    $core.String? displayName,
  }) {
    final result = create();
    if (displayName != null) result.displayName = displayName;
    return result;
  }

  UpdateDisplayNameRequest._();

  factory UpdateDisplayNameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateDisplayNameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDisplayNameRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDisplayNameRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDisplayNameRequest copyWith(
          void Function(UpdateDisplayNameRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateDisplayNameRequest))
          as UpdateDisplayNameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDisplayNameRequest create() => UpdateDisplayNameRequest._();
  @$core.override
  UpdateDisplayNameRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateDisplayNameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDisplayNameRequest>(create);
  static UpdateDisplayNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayName() => $_clearField(1);
}

class UpdateDisplayNameResponse extends $pb.GeneratedMessage {
  factory UpdateDisplayNameResponse({
    Project? project,
  }) {
    final result = create();
    if (project != null) result.project = project;
    return result;
  }

  UpdateDisplayNameResponse._();

  factory UpdateDisplayNameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateDisplayNameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDisplayNameResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOM<Project>(1, _omitFieldNames ? '' : 'project',
        subBuilder: Project.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDisplayNameResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDisplayNameResponse copyWith(
          void Function(UpdateDisplayNameResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateDisplayNameResponse))
          as UpdateDisplayNameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDisplayNameResponse create() => UpdateDisplayNameResponse._();
  @$core.override
  UpdateDisplayNameResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateDisplayNameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDisplayNameResponse>(create);
  static UpdateDisplayNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Project get project => $_getN(0);
  @$pb.TagNumber(1)
  set project(Project value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProject() => $_has(0);
  @$pb.TagNumber(1)
  void clearProject() => $_clearField(1);
  @$pb.TagNumber(1)
  Project ensureProject() => $_ensure(0);
}

class UpdateFCMServiceJSONRequest extends $pb.GeneratedMessage {
  factory UpdateFCMServiceJSONRequest({
    $core.String? fcmServiceJson,
  }) {
    final result = create();
    if (fcmServiceJson != null) result.fcmServiceJson = fcmServiceJson;
    return result;
  }

  UpdateFCMServiceJSONRequest._();

  factory UpdateFCMServiceJSONRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFCMServiceJSONRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFCMServiceJSONRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fcmServiceJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFCMServiceJSONRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFCMServiceJSONRequest copyWith(
          void Function(UpdateFCMServiceJSONRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateFCMServiceJSONRequest))
          as UpdateFCMServiceJSONRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFCMServiceJSONRequest create() =>
      UpdateFCMServiceJSONRequest._();
  @$core.override
  UpdateFCMServiceJSONRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFCMServiceJSONRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFCMServiceJSONRequest>(create);
  static UpdateFCMServiceJSONRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fcmServiceJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set fcmServiceJson($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFcmServiceJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearFcmServiceJson() => $_clearField(1);
}

class UpdateFCMServiceJSONResponse extends $pb.GeneratedMessage {
  factory UpdateFCMServiceJSONResponse() => create();

  UpdateFCMServiceJSONResponse._();

  factory UpdateFCMServiceJSONResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFCMServiceJSONResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFCMServiceJSONResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'dashboard.projects.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFCMServiceJSONResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFCMServiceJSONResponse copyWith(
          void Function(UpdateFCMServiceJSONResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateFCMServiceJSONResponse))
          as UpdateFCMServiceJSONResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFCMServiceJSONResponse create() =>
      UpdateFCMServiceJSONResponse._();
  @$core.override
  UpdateFCMServiceJSONResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFCMServiceJSONResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFCMServiceJSONResponse>(create);
  static UpdateFCMServiceJSONResponse? _defaultInstance;
}

class ProjectsServiceApi {
  final $pb.RpcClient _client;

  ProjectsServiceApi(this._client);

  $async.Future<BatchGetResponse> batchGet(
          $pb.ClientContext? ctx, BatchGetRequest request) =>
      _client.invoke<BatchGetResponse>(
          ctx, 'ProjectsService', 'BatchGet', request, BatchGetResponse());
  $async.Future<CreateResponse> create_(
          $pb.ClientContext? ctx, CreateRequest request) =>
      _client.invoke<CreateResponse>(
          ctx, 'ProjectsService', 'Create', request, CreateResponse());
  $async.Future<DeleteResponse> delete(
          $pb.ClientContext? ctx, DeleteRequest request) =>
      _client.invoke<DeleteResponse>(
          ctx, 'ProjectsService', 'Delete', request, DeleteResponse());
  $async.Future<GetResponse> get($pb.ClientContext? ctx, GetRequest request) =>
      _client.invoke<GetResponse>(
          ctx, 'ProjectsService', 'Get', request, GetResponse());
  $async.Future<UpdateDisplayNameResponse> updateDisplayName(
          $pb.ClientContext? ctx, UpdateDisplayNameRequest request) =>
      _client.invoke<UpdateDisplayNameResponse>(ctx, 'ProjectsService',
          'UpdateDisplayName', request, UpdateDisplayNameResponse());
  $async.Future<UpdateFCMServiceJSONResponse> updateFCMServiceJSON(
          $pb.ClientContext? ctx, UpdateFCMServiceJSONRequest request) =>
      _client.invoke<UpdateFCMServiceJSONResponse>(ctx, 'ProjectsService',
          'UpdateFCMServiceJSON', request, UpdateFCMServiceJSONResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
