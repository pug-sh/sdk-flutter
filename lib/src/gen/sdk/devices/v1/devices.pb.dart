// This is a generated file - do not edit.
//
// Generated from sdk/devices/v1/devices.proto.

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

class SubscribeRequest extends $pb.GeneratedMessage {
  factory SubscribeRequest({
    $core.String? deviceId,
    $core.String? platform,
    $core.String? profileExternalId,
    $core.String? profileId,
    $core.String? token,
    $0.Struct? properties,
  }) {
    final result = create();
    if (deviceId != null) result.deviceId = deviceId;
    if (platform != null) result.platform = platform;
    if (profileExternalId != null) result.profileExternalId = profileExternalId;
    if (profileId != null) result.profileId = profileId;
    if (token != null) result.token = token;
    if (properties != null) result.properties = properties;
    return result;
  }

  SubscribeRequest._();

  factory SubscribeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceId')
    ..aOS(2, _omitFieldNames ? '' : 'platform')
    ..aOS(3, _omitFieldNames ? '' : 'profileExternalId')
    ..aOS(4, _omitFieldNames ? '' : 'profileId')
    ..aOS(5, _omitFieldNames ? '' : 'token')
    ..aOM<$0.Struct>(6, _omitFieldNames ? '' : 'properties',
        subBuilder: $0.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeRequest copyWith(void Function(SubscribeRequest) updates) =>
      super.copyWith((message) => updates(message as SubscribeRequest))
          as SubscribeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeRequest create() => SubscribeRequest._();
  @$core.override
  SubscribeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscribeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeRequest>(create);
  static SubscribeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get platform => $_getSZ(1);
  @$pb.TagNumber(2)
  set platform($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlatform() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatform() => $_clearField(2);

  /// Optional — when provided, links the device to a profile.
  @$pb.TagNumber(3)
  $core.String get profileExternalId => $_getSZ(2);
  @$pb.TagNumber(3)
  set profileExternalId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProfileExternalId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfileExternalId() => $_clearField(3);

  /// Optional — alternative to profile_external_id for linking.
  @$pb.TagNumber(4)
  $core.String get profileId => $_getSZ(3);
  @$pb.TagNumber(4)
  set profileId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfileId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfileId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get token => $_getSZ(4);
  @$pb.TagNumber(5)
  set token($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearToken() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.Struct get properties => $_getN(5);
  @$pb.TagNumber(6)
  set properties($0.Struct value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasProperties() => $_has(5);
  @$pb.TagNumber(6)
  void clearProperties() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Struct ensureProperties() => $_ensure(5);
}

class SubscribeResponse extends $pb.GeneratedMessage {
  factory SubscribeResponse() => create();

  SubscribeResponse._();

  factory SubscribeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeResponse copyWith(void Function(SubscribeResponse) updates) =>
      super.copyWith((message) => updates(message as SubscribeResponse))
          as SubscribeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeResponse create() => SubscribeResponse._();
  @$core.override
  SubscribeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscribeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeResponse>(create);
  static SubscribeResponse? _defaultInstance;
}

class UpdateStatusRequest extends $pb.GeneratedMessage {
  factory UpdateStatusRequest({
    $core.String? id,
    $core.String? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    return result;
  }

  UpdateStatusRequest._();

  factory UpdateStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStatusRequest copyWith(void Function(UpdateStatusRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateStatusRequest))
          as UpdateStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStatusRequest create() => UpdateStatusRequest._();
  @$core.override
  UpdateStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateStatusRequest>(create);
  static UpdateStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
}

class UpdateStatusResponse extends $pb.GeneratedMessage {
  factory UpdateStatusResponse() => create();

  UpdateStatusResponse._();

  factory UpdateStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStatusResponse copyWith(void Function(UpdateStatusResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateStatusResponse))
          as UpdateStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStatusResponse create() => UpdateStatusResponse._();
  @$core.override
  UpdateStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateStatusResponse>(create);
  static UpdateStatusResponse? _defaultInstance;
}

class UpdateTokenRequest extends $pb.GeneratedMessage {
  factory UpdateTokenRequest({
    $core.String? id,
    $core.String? token,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (token != null) result.token = token;
    return result;
  }

  UpdateTokenRequest._();

  factory UpdateTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTokenRequest copyWith(void Function(UpdateTokenRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateTokenRequest))
          as UpdateTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTokenRequest create() => UpdateTokenRequest._();
  @$core.override
  UpdateTokenRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTokenRequest>(create);
  static UpdateTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => $_clearField(2);
}

class UpdateTokenResponse extends $pb.GeneratedMessage {
  factory UpdateTokenResponse() => create();

  UpdateTokenResponse._();

  factory UpdateTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTokenResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTokenResponse copyWith(void Function(UpdateTokenResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateTokenResponse))
          as UpdateTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTokenResponse create() => UpdateTokenResponse._();
  @$core.override
  UpdateTokenResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTokenResponse>(create);
  static UpdateTokenResponse? _defaultInstance;
}

enum DeviceOperationMessage_OperationPayload {
  subscribe,
  updateStatus,
  updateToken,
  notSet
}

class DeviceOperationMessage extends $pb.GeneratedMessage {
  factory DeviceOperationMessage({
    $core.String? deviceId,
    $core.String? projectId,
    SubscribePayload? subscribe,
    UpdateStatusPayload? updateStatus,
    UpdateTokenPayload? updateToken,
  }) {
    final result = create();
    if (deviceId != null) result.deviceId = deviceId;
    if (projectId != null) result.projectId = projectId;
    if (subscribe != null) result.subscribe = subscribe;
    if (updateStatus != null) result.updateStatus = updateStatus;
    if (updateToken != null) result.updateToken = updateToken;
    return result;
  }

  DeviceOperationMessage._();

  factory DeviceOperationMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceOperationMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, DeviceOperationMessage_OperationPayload>
      _DeviceOperationMessage_OperationPayloadByTag = {
    10: DeviceOperationMessage_OperationPayload.subscribe,
    11: DeviceOperationMessage_OperationPayload.updateStatus,
    12: DeviceOperationMessage_OperationPayload.updateToken,
    0: DeviceOperationMessage_OperationPayload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceOperationMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..oo(0, [10, 11, 12])
    ..aOS(1, _omitFieldNames ? '' : 'deviceId')
    ..aOS(2, _omitFieldNames ? '' : 'projectId')
    ..aOM<SubscribePayload>(10, _omitFieldNames ? '' : 'subscribe',
        subBuilder: SubscribePayload.create)
    ..aOM<UpdateStatusPayload>(11, _omitFieldNames ? '' : 'updateStatus',
        subBuilder: UpdateStatusPayload.create)
    ..aOM<UpdateTokenPayload>(12, _omitFieldNames ? '' : 'updateToken',
        subBuilder: UpdateTokenPayload.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceOperationMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceOperationMessage copyWith(
          void Function(DeviceOperationMessage) updates) =>
      super.copyWith((message) => updates(message as DeviceOperationMessage))
          as DeviceOperationMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceOperationMessage create() => DeviceOperationMessage._();
  @$core.override
  DeviceOperationMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceOperationMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceOperationMessage>(create);
  static DeviceOperationMessage? _defaultInstance;

  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  DeviceOperationMessage_OperationPayload whichOperationPayload() =>
      _DeviceOperationMessage_OperationPayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  void clearOperationPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectId() => $_clearField(2);

  @$pb.TagNumber(10)
  SubscribePayload get subscribe => $_getN(2);
  @$pb.TagNumber(10)
  set subscribe(SubscribePayload value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasSubscribe() => $_has(2);
  @$pb.TagNumber(10)
  void clearSubscribe() => $_clearField(10);
  @$pb.TagNumber(10)
  SubscribePayload ensureSubscribe() => $_ensure(2);

  @$pb.TagNumber(11)
  UpdateStatusPayload get updateStatus => $_getN(3);
  @$pb.TagNumber(11)
  set updateStatus(UpdateStatusPayload value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdateStatus() => $_has(3);
  @$pb.TagNumber(11)
  void clearUpdateStatus() => $_clearField(11);
  @$pb.TagNumber(11)
  UpdateStatusPayload ensureUpdateStatus() => $_ensure(3);

  @$pb.TagNumber(12)
  UpdateTokenPayload get updateToken => $_getN(4);
  @$pb.TagNumber(12)
  set updateToken(UpdateTokenPayload value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasUpdateToken() => $_has(4);
  @$pb.TagNumber(12)
  void clearUpdateToken() => $_clearField(12);
  @$pb.TagNumber(12)
  UpdateTokenPayload ensureUpdateToken() => $_ensure(4);
}

class SubscribePayload extends $pb.GeneratedMessage {
  factory SubscribePayload({
    $core.String? platform,
    $core.String? profileExternalId,
    $core.String? profileId,
    $core.String? token,
    $0.Struct? properties,
  }) {
    final result = create();
    if (platform != null) result.platform = platform;
    if (profileExternalId != null) result.profileExternalId = profileExternalId;
    if (profileId != null) result.profileId = profileId;
    if (token != null) result.token = token;
    if (properties != null) result.properties = properties;
    return result;
  }

  SubscribePayload._();

  factory SubscribePayload.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribePayload.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribePayload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'platform')
    ..aOS(2, _omitFieldNames ? '' : 'profileExternalId')
    ..aOS(3, _omitFieldNames ? '' : 'profileId')
    ..aOS(4, _omitFieldNames ? '' : 'token')
    ..aOM<$0.Struct>(5, _omitFieldNames ? '' : 'properties',
        subBuilder: $0.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribePayload clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribePayload copyWith(void Function(SubscribePayload) updates) =>
      super.copyWith((message) => updates(message as SubscribePayload))
          as SubscribePayload;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribePayload create() => SubscribePayload._();
  @$core.override
  SubscribePayload createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscribePayload getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribePayload>(create);
  static SubscribePayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get platform => $_getSZ(0);
  @$pb.TagNumber(1)
  set platform($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPlatform() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlatform() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get profileExternalId => $_getSZ(1);
  @$pb.TagNumber(2)
  set profileExternalId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProfileExternalId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProfileExternalId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get profileId => $_getSZ(2);
  @$pb.TagNumber(3)
  set profileId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProfileId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfileId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get token => $_getSZ(3);
  @$pb.TagNumber(4)
  set token($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Struct get properties => $_getN(4);
  @$pb.TagNumber(5)
  set properties($0.Struct value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasProperties() => $_has(4);
  @$pb.TagNumber(5)
  void clearProperties() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Struct ensureProperties() => $_ensure(4);
}

class UpdateStatusPayload extends $pb.GeneratedMessage {
  factory UpdateStatusPayload({
    $core.String? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  UpdateStatusPayload._();

  factory UpdateStatusPayload.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateStatusPayload.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateStatusPayload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStatusPayload clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateStatusPayload copyWith(void Function(UpdateStatusPayload) updates) =>
      super.copyWith((message) => updates(message as UpdateStatusPayload))
          as UpdateStatusPayload;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateStatusPayload create() => UpdateStatusPayload._();
  @$core.override
  UpdateStatusPayload createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateStatusPayload getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateStatusPayload>(create);
  static UpdateStatusPayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class UpdateTokenPayload extends $pb.GeneratedMessage {
  factory UpdateTokenPayload({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  UpdateTokenPayload._();

  factory UpdateTokenPayload.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTokenPayload.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTokenPayload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sdk.devices.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTokenPayload clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTokenPayload copyWith(void Function(UpdateTokenPayload) updates) =>
      super.copyWith((message) => updates(message as UpdateTokenPayload))
          as UpdateTokenPayload;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTokenPayload create() => UpdateTokenPayload._();
  @$core.override
  UpdateTokenPayload createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateTokenPayload getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTokenPayload>(create);
  static UpdateTokenPayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class DevicesServiceApi {
  final $pb.RpcClient _client;

  DevicesServiceApi(this._client);

  $async.Future<SubscribeResponse> subscribe(
          $pb.ClientContext? ctx, SubscribeRequest request) =>
      _client.invoke<SubscribeResponse>(
          ctx, 'DevicesService', 'Subscribe', request, SubscribeResponse());
  $async.Future<UpdateStatusResponse> updateStatus(
          $pb.ClientContext? ctx, UpdateStatusRequest request) =>
      _client.invoke<UpdateStatusResponse>(ctx, 'DevicesService',
          'UpdateStatus', request, UpdateStatusResponse());
  $async.Future<UpdateTokenResponse> updateToken(
          $pb.ClientContext? ctx, UpdateTokenRequest request) =>
      _client.invoke<UpdateTokenResponse>(
          ctx, 'DevicesService', 'UpdateToken', request, UpdateTokenResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
