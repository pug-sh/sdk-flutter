// This is a generated file - do not edit.
//
// Generated from common/events/v1/workspace_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class WorkspaceCreatedProperties extends $pb.GeneratedMessage {
  factory WorkspaceCreatedProperties({
    $core.String? workspaceId,
    $core.String? workspaceName,
  }) {
    final result = create();
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (workspaceName != null) result.workspaceName = workspaceName;
    return result;
  }

  WorkspaceCreatedProperties._();

  factory WorkspaceCreatedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WorkspaceCreatedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkspaceCreatedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceCreatedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceCreatedProperties copyWith(
          void Function(WorkspaceCreatedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as WorkspaceCreatedProperties))
          as WorkspaceCreatedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkspaceCreatedProperties create() => WorkspaceCreatedProperties._();
  @$core.override
  WorkspaceCreatedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WorkspaceCreatedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkspaceCreatedProperties>(create);
  static WorkspaceCreatedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workspaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workspaceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWorkspaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkspaceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get workspaceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set workspaceName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWorkspaceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkspaceName() => $_clearField(2);
}

class WorkspaceJoinedProperties extends $pb.GeneratedMessage {
  factory WorkspaceJoinedProperties({
    $core.String? workspaceId,
    $core.String? role,
  }) {
    final result = create();
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (role != null) result.role = role;
    return result;
  }

  WorkspaceJoinedProperties._();

  factory WorkspaceJoinedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WorkspaceJoinedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkspaceJoinedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceJoinedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceJoinedProperties copyWith(
          void Function(WorkspaceJoinedProperties) updates) =>
      super.copyWith((message) => updates(message as WorkspaceJoinedProperties))
          as WorkspaceJoinedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkspaceJoinedProperties create() => WorkspaceJoinedProperties._();
  @$core.override
  WorkspaceJoinedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WorkspaceJoinedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkspaceJoinedProperties>(create);
  static WorkspaceJoinedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workspaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workspaceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWorkspaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkspaceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);
}

class WorkspaceDeletedProperties extends $pb.GeneratedMessage {
  factory WorkspaceDeletedProperties({
    $core.String? workspaceId,
    $core.String? reason,
  }) {
    final result = create();
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (reason != null) result.reason = reason;
    return result;
  }

  WorkspaceDeletedProperties._();

  factory WorkspaceDeletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WorkspaceDeletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkspaceDeletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceDeletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceDeletedProperties copyWith(
          void Function(WorkspaceDeletedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as WorkspaceDeletedProperties))
          as WorkspaceDeletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkspaceDeletedProperties create() => WorkspaceDeletedProperties._();
  @$core.override
  WorkspaceDeletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WorkspaceDeletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkspaceDeletedProperties>(create);
  static WorkspaceDeletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workspaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workspaceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWorkspaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkspaceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class WorkspaceRoleChangedProperties extends $pb.GeneratedMessage {
  factory WorkspaceRoleChangedProperties({
    $core.String? workspaceId,
    $core.String? memberId,
    $core.String? previousRole,
    $core.String? newRole,
  }) {
    final result = create();
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (memberId != null) result.memberId = memberId;
    if (previousRole != null) result.previousRole = previousRole;
    if (newRole != null) result.newRole = newRole;
    return result;
  }

  WorkspaceRoleChangedProperties._();

  factory WorkspaceRoleChangedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WorkspaceRoleChangedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkspaceRoleChangedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'previousRole')
    ..aOS(4, _omitFieldNames ? '' : 'newRole')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceRoleChangedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceRoleChangedProperties copyWith(
          void Function(WorkspaceRoleChangedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as WorkspaceRoleChangedProperties))
          as WorkspaceRoleChangedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkspaceRoleChangedProperties create() =>
      WorkspaceRoleChangedProperties._();
  @$core.override
  WorkspaceRoleChangedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WorkspaceRoleChangedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkspaceRoleChangedProperties>(create);
  static WorkspaceRoleChangedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workspaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workspaceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWorkspaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkspaceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get previousRole => $_getSZ(2);
  @$pb.TagNumber(3)
  set previousRole($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPreviousRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreviousRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get newRole => $_getSZ(3);
  @$pb.TagNumber(4)
  set newRole($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewRole() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewRole() => $_clearField(4);
}

class WorkspaceSettingsUpdatedProperties extends $pb.GeneratedMessage {
  factory WorkspaceSettingsUpdatedProperties({
    $core.String? workspaceId,
    $core.String? setting,
  }) {
    final result = create();
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (setting != null) result.setting = setting;
    return result;
  }

  WorkspaceSettingsUpdatedProperties._();

  factory WorkspaceSettingsUpdatedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WorkspaceSettingsUpdatedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkspaceSettingsUpdatedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(2, _omitFieldNames ? '' : 'setting')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceSettingsUpdatedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WorkspaceSettingsUpdatedProperties copyWith(
          void Function(WorkspaceSettingsUpdatedProperties) updates) =>
      super.copyWith((message) =>
              updates(message as WorkspaceSettingsUpdatedProperties))
          as WorkspaceSettingsUpdatedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkspaceSettingsUpdatedProperties create() =>
      WorkspaceSettingsUpdatedProperties._();
  @$core.override
  WorkspaceSettingsUpdatedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WorkspaceSettingsUpdatedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkspaceSettingsUpdatedProperties>(
          create);
  static WorkspaceSettingsUpdatedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workspaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set workspaceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWorkspaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkspaceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get setting => $_getSZ(1);
  @$pb.TagNumber(2)
  set setting($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSetting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetting() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
