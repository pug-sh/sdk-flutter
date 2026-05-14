// This is a generated file - do not edit.
//
// Generated from sdk/profiles/v1/profiles.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class IdentifyRequest extends $pb.GeneratedMessage {
  factory IdentifyRequest({
    $core.String? externalId,
    $0.Struct? traits,
    $core.String? anonymousId,
    $core.String? deviceId,
  }) {
    final result = create();
    if (externalId != null) result.externalId = externalId;
    if (traits != null) result.traits = traits;
    if (anonymousId != null) result.anonymousId = anonymousId;
    if (deviceId != null) result.deviceId = deviceId;
    return result;
  }

  IdentifyRequest._();

  factory IdentifyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IdentifyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IdentifyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'sdk.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'externalId')
    ..aOM<$0.Struct>(2, _omitFieldNames ? '' : 'traits',
        subBuilder: $0.Struct.create)
    ..aOS(3, _omitFieldNames ? '' : 'anonymousId')
    ..aOS(4, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentifyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentifyRequest copyWith(void Function(IdentifyRequest) updates) =>
      super.copyWith((message) => updates(message as IdentifyRequest))
          as IdentifyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdentifyRequest create() => IdentifyRequest._();
  @$core.override
  IdentifyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IdentifyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IdentifyRequest>(create);
  static IdentifyRequest? _defaultInstance;

  /// Stable user identifier (e.g. email, database ID).
  @$pb.TagNumber(1)
  $core.String get externalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set externalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExternalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExternalId() => $_clearField(1);

  /// Profile properties — shallow-merged into existing properties. On key conflict,
  /// these values take precedence over previously stored values.
  @$pb.TagNumber(2)
  $0.Struct get traits => $_getN(1);
  @$pb.TagNumber(2)
  set traits($0.Struct value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTraits() => $_has(1);
  @$pb.TagNumber(2)
  void clearTraits() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Struct ensureTraits() => $_ensure(1);

  /// The SDK-generated anonymous ID. The SDK should send this on first identify
  /// to trigger merge-and-soft-delete of the anonymous profile. Must start with "anon-".
  @$pb.TagNumber(3)
  $core.String get anonymousId => $_getSZ(2);
  @$pb.TagNumber(3)
  set anonymousId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAnonymousId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnonymousId() => $_clearField(3);

  /// The device to assign to this profile. The SDK should send this on first
  /// identify and on account switch (external_id changed) — not on every call,
  /// to avoid unnecessary DB writes. Omit for web SDKs without push support.
  @$pb.TagNumber(4)
  $core.String get deviceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceId() => $_clearField(4);
}

class IdentifyResponse extends $pb.GeneratedMessage {
  factory IdentifyResponse() => create();

  IdentifyResponse._();

  factory IdentifyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IdentifyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IdentifyResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'sdk.profiles.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentifyResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IdentifyResponse copyWith(void Function(IdentifyResponse) updates) =>
      super.copyWith((message) => updates(message as IdentifyResponse))
          as IdentifyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdentifyResponse create() => IdentifyResponse._();
  @$core.override
  IdentifyResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IdentifyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IdentifyResponse>(create);
  static IdentifyResponse? _defaultInstance;
}

/// ProfileIdentifyMessage is the internal NATS envelope for the identify worker.
/// project_id is injected server-side from the authenticated principal.
class ProfileIdentifyMessage extends $pb.GeneratedMessage {
  factory ProfileIdentifyMessage({
    $core.String? externalId,
    $0.Struct? traits,
    $core.String? projectId,
    $core.String? anonymousId,
    $core.String? deviceId,
  }) {
    final result = create();
    if (externalId != null) result.externalId = externalId;
    if (traits != null) result.traits = traits;
    if (projectId != null) result.projectId = projectId;
    if (anonymousId != null) result.anonymousId = anonymousId;
    if (deviceId != null) result.deviceId = deviceId;
    return result;
  }

  ProfileIdentifyMessage._();

  factory ProfileIdentifyMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileIdentifyMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileIdentifyMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'sdk.profiles.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'externalId')
    ..aOM<$0.Struct>(2, _omitFieldNames ? '' : 'traits',
        subBuilder: $0.Struct.create)
    ..aOS(3, _omitFieldNames ? '' : 'projectId')
    ..aOS(4, _omitFieldNames ? '' : 'anonymousId')
    ..aOS(5, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileIdentifyMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileIdentifyMessage copyWith(
          void Function(ProfileIdentifyMessage) updates) =>
      super.copyWith((message) => updates(message as ProfileIdentifyMessage))
          as ProfileIdentifyMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileIdentifyMessage create() => ProfileIdentifyMessage._();
  @$core.override
  ProfileIdentifyMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileIdentifyMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileIdentifyMessage>(create);
  static ProfileIdentifyMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get externalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set externalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExternalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExternalId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Struct get traits => $_getN(1);
  @$pb.TagNumber(2)
  set traits($0.Struct value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTraits() => $_has(1);
  @$pb.TagNumber(2)
  void clearTraits() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Struct ensureTraits() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get projectId => $_getSZ(2);
  @$pb.TagNumber(3)
  set projectId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProjectId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProjectId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get anonymousId => $_getSZ(3);
  @$pb.TagNumber(4)
  set anonymousId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAnonymousId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAnonymousId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get deviceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set deviceId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDeviceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceId() => $_clearField(5);
}

class ProfilesSDKServiceApi {
  final $pb.RpcClient _client;

  ProfilesSDKServiceApi(this._client);

  /// Identify creates or updates a profile by external_id. When anonymous_id
  /// is provided, the anonymous profile is merged into the identified one
  /// (properties, devices) and then soft-deleted.
  $async.Future<IdentifyResponse> identify(
          $pb.ClientContext? ctx, IdentifyRequest request) =>
      _client.invoke<IdentifyResponse>(
          ctx, 'ProfilesSDKService', 'Identify', request, IdentifyResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
