// This is a generated file - do not edit.
//
// Generated from workers/profiles/v1/profiles.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $0;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ProfileAliasMessage extends $pb.GeneratedMessage {
  factory ProfileAliasMessage({
    $core.String? aliasId,
    $core.String? profileId,
    $core.String? externalId,
    $core.String? projectId,
  }) {
    final result = create();
    if (aliasId != null) result.aliasId = aliasId;
    if (profileId != null) result.profileId = profileId;
    if (externalId != null) result.externalId = externalId;
    if (projectId != null) result.projectId = projectId;
    return result;
  }

  ProfileAliasMessage._();

  factory ProfileAliasMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileAliasMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileAliasMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'workers.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'aliasId')
    ..aOS(2, _omitFieldNames ? '' : 'profileId')
    ..aOS(3, _omitFieldNames ? '' : 'externalId')
    ..aOS(4, _omitFieldNames ? '' : 'projectId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileAliasMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileAliasMessage copyWith(void Function(ProfileAliasMessage) updates) =>
      super.copyWith((message) => updates(message as ProfileAliasMessage))
          as ProfileAliasMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileAliasMessage create() => ProfileAliasMessage._();
  @$core.override
  ProfileAliasMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileAliasMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileAliasMessage>(create);
  static ProfileAliasMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get aliasId => $_getSZ(0);
  @$pb.TagNumber(1)
  set aliasId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAliasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAliasId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get profileId => $_getSZ(1);
  @$pb.TagNumber(2)
  set profileId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProfileId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProfileId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get externalId => $_getSZ(2);
  @$pb.TagNumber(3)
  set externalId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExternalId() => $_has(2);
  @$pb.TagNumber(3)
  void clearExternalId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get projectId => $_getSZ(3);
  @$pb.TagNumber(4)
  set projectId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProjectId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProjectId() => $_clearField(4);
}

/// ProfileUpsertMessage is published to profiles.upsert by the identify and
/// delete handlers to sync profile state to ClickHouse.
/// The upsert worker writes all fields into a ReplacingMergeTree keyed by (project_id, profile_id).
class ProfileUpsertMessage extends $pb.GeneratedMessage {
  factory ProfileUpsertMessage({
    $core.String? profileId,
    $core.String? projectId,
    $core.String? externalId,
    $0.Struct? properties,
    $core.bool? isDeleted,
    $1.Timestamp? createTime,
    $1.Timestamp? updateTime,
  }) {
    final result = create();
    if (profileId != null) result.profileId = profileId;
    if (projectId != null) result.projectId = projectId;
    if (externalId != null) result.externalId = externalId;
    if (properties != null) result.properties = properties;
    if (isDeleted != null) result.isDeleted = isDeleted;
    if (createTime != null) result.createTime = createTime;
    if (updateTime != null) result.updateTime = updateTime;
    return result;
  }

  ProfileUpsertMessage._();

  factory ProfileUpsertMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileUpsertMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileUpsertMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'workers.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'profileId')
    ..aOS(2, _omitFieldNames ? '' : 'projectId')
    ..aOS(3, _omitFieldNames ? '' : 'externalId')
    ..aOM<$0.Struct>(4, _omitFieldNames ? '' : 'properties',
        subBuilder: $0.Struct.create)
    ..aOB(5, _omitFieldNames ? '' : 'isDeleted')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createTime',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileUpsertMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileUpsertMessage copyWith(void Function(ProfileUpsertMessage) updates) =>
      super.copyWith((message) => updates(message as ProfileUpsertMessage))
          as ProfileUpsertMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileUpsertMessage create() => ProfileUpsertMessage._();
  @$core.override
  ProfileUpsertMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileUpsertMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileUpsertMessage>(create);
  static ProfileUpsertMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get profileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set profileId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProfileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfileId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectId() => $_clearField(2);

  /// May be empty for anonymous profiles that have not been identified yet.
  @$pb.TagNumber(3)
  $core.String get externalId => $_getSZ(2);
  @$pb.TagNumber(3)
  set externalId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExternalId() => $_has(2);
  @$pb.TagNumber(3)
  void clearExternalId() => $_clearField(3);

  /// JSONB profile properties. Empty struct for deletes.
  @$pb.TagNumber(4)
  $0.Struct get properties => $_getN(3);
  @$pb.TagNumber(4)
  set properties($0.Struct value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasProperties() => $_has(3);
  @$pb.TagNumber(4)
  void clearProperties() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Struct ensureProperties() => $_ensure(3);

  /// When true, this message represents a soft-delete in ClickHouse.
  /// The upsert worker maps this to a UInt8 is_deleted column (1 = deleted).
  /// properties, external_id, create_time, and update_time may be zero-valued for deletes.
  @$pb.TagNumber(5)
  $core.bool get isDeleted => $_getBF(4);
  @$pb.TagNumber(5)
  set isDeleted($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsDeleted() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsDeleted() => $_clearField(5);

  /// PostgreSQL row timestamps. Zero-valued for soft-delete messages.
  @$pb.TagNumber(6)
  $1.Timestamp get createTime => $_getN(5);
  @$pb.TagNumber(6)
  set createTime($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCreateTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreateTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreateTime() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get updateTime => $_getN(6);
  @$pb.TagNumber(7)
  set updateTime($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdateTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdateTime() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureUpdateTime() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
