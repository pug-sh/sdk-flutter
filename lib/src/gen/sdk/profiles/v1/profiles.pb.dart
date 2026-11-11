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

  /// Stable, unique user identifier: your database user ID, not an email, which
  /// can change.
  /// The 'cookieless-' prefix is server-owned: ingest mints those ids and the
  /// reserved-prefix rule on an incoming event's distinct_id already refuses them
  /// from clients. external_id needs the same guard because post-identify events
  /// are keyed by external_id, so an id accepted here comes back as a distinct_id
  /// and BatchCreate drops every event of that user.
  @$pb.TagNumber(1)
  $core.String get externalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set externalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExternalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExternalId() => $_clearField(1);

  /// Profile properties, shallow-merged into existing properties. On key conflict,
  /// these values take precedence over previously stored values. A trait whose key,
  /// or any string in it, holds a NUL can't be stored and is dropped.
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
  /// identify and on account switch (external_id changed), not on every call,
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

class BatchIdentifyRequest extends $pb.GeneratedMessage {
  factory BatchIdentifyRequest({
    $core.Iterable<IdentifyRequest>? identifies,
  }) {
    final result = create();
    if (identifies != null) result.identifies.addAll(identifies);
    return result;
  }

  BatchIdentifyRequest._();

  factory BatchIdentifyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchIdentifyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchIdentifyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'sdk.profiles.v1'),
      createEmptyInstance: create)
    ..pPM<IdentifyRequest>(1, _omitFieldNames ? '' : 'identifies',
        subBuilder: IdentifyRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchIdentifyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchIdentifyRequest copyWith(void Function(BatchIdentifyRequest) updates) =>
      super.copyWith((message) => updates(message as BatchIdentifyRequest))
          as BatchIdentifyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchIdentifyRequest create() => BatchIdentifyRequest._();
  @$core.override
  BatchIdentifyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchIdentifyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchIdentifyRequest>(create);
  static BatchIdentifyRequest? _defaultInstance;

  /// BatchIdentify validates each item on its own with IdentifyRequest's rules,
  /// so an invalid item is skipped and the rest are queued.
  @$pb.TagNumber(1)
  $pb.PbList<IdentifyRequest> get identifies => $_getList(0);
}

class BatchIdentifyResponse extends $pb.GeneratedMessage {
  factory BatchIdentifyResponse({
    $core.int? accepted,
    $core.Iterable<InvalidIdentify>? invalidIdentifies,
  }) {
    final result = create();
    if (accepted != null) result.accepted = accepted;
    if (invalidIdentifies != null)
      result.invalidIdentifies.addAll(invalidIdentifies);
    return result;
  }

  BatchIdentifyResponse._();

  factory BatchIdentifyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchIdentifyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchIdentifyResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'sdk.profiles.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'accepted', fieldType: $pb.PbFieldType.OU3)
    ..pPM<InvalidIdentify>(2, _omitFieldNames ? '' : 'invalidIdentifies',
        subBuilder: InvalidIdentify.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchIdentifyResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchIdentifyResponse copyWith(
          void Function(BatchIdentifyResponse) updates) =>
      super.copyWith((message) => updates(message as BatchIdentifyResponse))
          as BatchIdentifyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchIdentifyResponse create() => BatchIdentifyResponse._();
  @$core.override
  BatchIdentifyResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchIdentifyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchIdentifyResponse>(create);
  static BatchIdentifyResponse? _defaultInstance;

  /// Identifies queued for the worker, not yet applied.
  @$pb.TagNumber(1)
  $core.int get accepted => $_getIZ(0);
  @$pb.TagNumber(1)
  set accepted($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccepted() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccepted() => $_clearField(1);

  /// The items skipped for breaking a validation rule, in request order.
  @$pb.TagNumber(2)
  $pb.PbList<InvalidIdentify> get invalidIdentifies => $_getList(1);
}

class InvalidIdentify extends $pb.GeneratedMessage {
  factory InvalidIdentify({
    $core.int? index,
    $core.Iterable<$core.String>? violations,
  }) {
    final result = create();
    if (index != null) result.index = index;
    if (violations != null) result.violations.addAll(violations);
    return result;
  }

  InvalidIdentify._();

  factory InvalidIdentify.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvalidIdentify.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvalidIdentify',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'sdk.profiles.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'index', fieldType: $pb.PbFieldType.OU3)
    ..pPS(2, _omitFieldNames ? '' : 'violations')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidIdentify clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvalidIdentify copyWith(void Function(InvalidIdentify) updates) =>
      super.copyWith((message) => updates(message as InvalidIdentify))
          as InvalidIdentify;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvalidIdentify create() => InvalidIdentify._();
  @$core.override
  InvalidIdentify createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InvalidIdentify getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvalidIdentify>(create);
  static InvalidIdentify? _defaultInstance;

  /// Position in BatchIdentifyRequest.identifies, counting from 0.
  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => $_clearField(1);

  /// The rules it broke, e.g. "external_id: external_id must not start with the
  /// reserved 'cookieless-' prefix". At most 10, then one more entry that counts
  /// the rest, e.g. "and 3 more".
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get violations => $_getList(1);
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

  /// Mirrors IdentifyRequest.external_id: the worker re-validates this envelope,
  /// so its rules hold at both stages rather than trusting that the value only
  /// ever arrives from an already-validated request.
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

  /// BatchIdentify publishes many identifies in one request for the identify
  /// worker. Items for one external_id that only set traits may merge in order,
  /// later values winning. It is not atomic: an error can follow a partial publish,
  /// and a retry repeats what was already published. The worker applies separate
  /// messages in no guaranteed order. An item that breaks a validation rule is
  /// skipped and listed in invalid_identifies; the rest are still queued.
  $async.Future<BatchIdentifyResponse> batchIdentify(
          $pb.ClientContext? ctx, BatchIdentifyRequest request) =>
      _client.invoke<BatchIdentifyResponse>(ctx, 'ProfilesSDKService',
          'BatchIdentify', request, BatchIdentifyResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
