// This is a generated file - do not edit.
//
// Generated from common/events/v1/integration_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class IntegrationConnectedProperties extends $pb.GeneratedMessage {
  factory IntegrationConnectedProperties({
    $core.String? integrationId,
    $core.String? integrationType,
  }) {
    final result = create();
    if (integrationId != null) result.integrationId = integrationId;
    if (integrationType != null) result.integrationType = integrationType;
    return result;
  }

  IntegrationConnectedProperties._();

  factory IntegrationConnectedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IntegrationConnectedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IntegrationConnectedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'integrationId')
    ..aOS(2, _omitFieldNames ? '' : 'integrationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IntegrationConnectedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IntegrationConnectedProperties copyWith(
          void Function(IntegrationConnectedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as IntegrationConnectedProperties))
          as IntegrationConnectedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IntegrationConnectedProperties create() =>
      IntegrationConnectedProperties._();
  @$core.override
  IntegrationConnectedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IntegrationConnectedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IntegrationConnectedProperties>(create);
  static IntegrationConnectedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get integrationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set integrationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIntegrationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIntegrationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get integrationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set integrationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIntegrationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntegrationType() => $_clearField(2);
}

class IntegrationDisconnectedProperties extends $pb.GeneratedMessage {
  factory IntegrationDisconnectedProperties({
    $core.String? integrationId,
    $core.String? integrationType,
    $core.String? reason,
  }) {
    final result = create();
    if (integrationId != null) result.integrationId = integrationId;
    if (integrationType != null) result.integrationType = integrationType;
    if (reason != null) result.reason = reason;
    return result;
  }

  IntegrationDisconnectedProperties._();

  factory IntegrationDisconnectedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IntegrationDisconnectedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IntegrationDisconnectedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'integrationId')
    ..aOS(2, _omitFieldNames ? '' : 'integrationType')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IntegrationDisconnectedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IntegrationDisconnectedProperties copyWith(
          void Function(IntegrationDisconnectedProperties) updates) =>
      super.copyWith((message) =>
              updates(message as IntegrationDisconnectedProperties))
          as IntegrationDisconnectedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IntegrationDisconnectedProperties create() =>
      IntegrationDisconnectedProperties._();
  @$core.override
  IntegrationDisconnectedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IntegrationDisconnectedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IntegrationDisconnectedProperties>(
          create);
  static IntegrationDisconnectedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get integrationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set integrationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIntegrationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIntegrationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get integrationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set integrationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIntegrationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntegrationType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
