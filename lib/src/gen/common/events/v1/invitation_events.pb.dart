// This is a generated file - do not edit.
//
// Generated from common/events/v1/invitation_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InviteSentProperties extends $pb.GeneratedMessage {
  factory InviteSentProperties({
    $core.String? inviteId,
    $core.String? workspaceId,
    $core.String? inviterId,
    $core.String? inviteeId,
    $core.String? inviteeEmail,
    $core.String? role,
  }) {
    final result = create();
    if (inviteId != null) result.inviteId = inviteId;
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (inviterId != null) result.inviterId = inviterId;
    if (inviteeId != null) result.inviteeId = inviteeId;
    if (inviteeEmail != null) result.inviteeEmail = inviteeEmail;
    if (role != null) result.role = role;
    return result;
  }

  InviteSentProperties._();

  factory InviteSentProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InviteSentProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InviteSentProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'inviteId')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(3, _omitFieldNames ? '' : 'inviterId')
    ..aOS(4, _omitFieldNames ? '' : 'inviteeId')
    ..aOS(5, _omitFieldNames ? '' : 'inviteeEmail')
    ..aOS(6, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteSentProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteSentProperties copyWith(void Function(InviteSentProperties) updates) =>
      super.copyWith((message) => updates(message as InviteSentProperties))
          as InviteSentProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InviteSentProperties create() => InviteSentProperties._();
  @$core.override
  InviteSentProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InviteSentProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InviteSentProperties>(create);
  static InviteSentProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inviteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set inviteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInviteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInviteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get workspaceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set workspaceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWorkspaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkspaceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get inviterId => $_getSZ(2);
  @$pb.TagNumber(3)
  set inviterId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInviterId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInviterId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get inviteeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set inviteeId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInviteeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInviteeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get inviteeEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set inviteeEmail($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInviteeEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearInviteeEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => $_clearField(6);
}

class InviteAcceptedProperties extends $pb.GeneratedMessage {
  factory InviteAcceptedProperties({
    $core.String? inviteId,
    $core.String? workspaceId,
    $core.String? inviterId,
    $core.String? inviteeId,
    $core.String? inviteeEmail,
    $core.String? role,
  }) {
    final result = create();
    if (inviteId != null) result.inviteId = inviteId;
    if (workspaceId != null) result.workspaceId = workspaceId;
    if (inviterId != null) result.inviterId = inviterId;
    if (inviteeId != null) result.inviteeId = inviteeId;
    if (inviteeEmail != null) result.inviteeEmail = inviteeEmail;
    if (role != null) result.role = role;
    return result;
  }

  InviteAcceptedProperties._();

  factory InviteAcceptedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InviteAcceptedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InviteAcceptedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'inviteId')
    ..aOS(2, _omitFieldNames ? '' : 'workspaceId')
    ..aOS(3, _omitFieldNames ? '' : 'inviterId')
    ..aOS(4, _omitFieldNames ? '' : 'inviteeId')
    ..aOS(5, _omitFieldNames ? '' : 'inviteeEmail')
    ..aOS(6, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteAcceptedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteAcceptedProperties copyWith(
          void Function(InviteAcceptedProperties) updates) =>
      super.copyWith((message) => updates(message as InviteAcceptedProperties))
          as InviteAcceptedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InviteAcceptedProperties create() => InviteAcceptedProperties._();
  @$core.override
  InviteAcceptedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InviteAcceptedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InviteAcceptedProperties>(create);
  static InviteAcceptedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inviteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set inviteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInviteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInviteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get workspaceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set workspaceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWorkspaceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkspaceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get inviterId => $_getSZ(2);
  @$pb.TagNumber(3)
  set inviterId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInviterId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInviterId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get inviteeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set inviteeId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInviteeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearInviteeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get inviteeEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set inviteeEmail($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInviteeEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearInviteeEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
