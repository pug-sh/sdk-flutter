// This is a generated file - do not edit.
//
// Generated from common/events/v1/api_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ApiKeyCreatedProperties extends $pb.GeneratedMessage {
  factory ApiKeyCreatedProperties({
    $core.String? apiKeyId,
    $core.String? name,
    $core.String? scope,
  }) {
    final result = create();
    if (apiKeyId != null) result.apiKeyId = apiKeyId;
    if (name != null) result.name = name;
    if (scope != null) result.scope = scope;
    return result;
  }

  ApiKeyCreatedProperties._();

  factory ApiKeyCreatedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApiKeyCreatedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApiKeyCreatedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apiKeyId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'scope')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApiKeyCreatedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApiKeyCreatedProperties copyWith(
          void Function(ApiKeyCreatedProperties) updates) =>
      super.copyWith((message) => updates(message as ApiKeyCreatedProperties))
          as ApiKeyCreatedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApiKeyCreatedProperties create() => ApiKeyCreatedProperties._();
  @$core.override
  ApiKeyCreatedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ApiKeyCreatedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApiKeyCreatedProperties>(create);
  static ApiKeyCreatedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get apiKeyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set apiKeyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApiKeyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApiKeyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get scope => $_getSZ(2);
  @$pb.TagNumber(3)
  set scope($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasScope() => $_has(2);
  @$pb.TagNumber(3)
  void clearScope() => $_clearField(3);
}

class ApiKeyRevokedProperties extends $pb.GeneratedMessage {
  factory ApiKeyRevokedProperties({
    $core.String? apiKeyId,
    $core.String? name,
    $core.String? reason,
  }) {
    final result = create();
    if (apiKeyId != null) result.apiKeyId = apiKeyId;
    if (name != null) result.name = name;
    if (reason != null) result.reason = reason;
    return result;
  }

  ApiKeyRevokedProperties._();

  factory ApiKeyRevokedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApiKeyRevokedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApiKeyRevokedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apiKeyId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApiKeyRevokedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApiKeyRevokedProperties copyWith(
          void Function(ApiKeyRevokedProperties) updates) =>
      super.copyWith((message) => updates(message as ApiKeyRevokedProperties))
          as ApiKeyRevokedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApiKeyRevokedProperties create() => ApiKeyRevokedProperties._();
  @$core.override
  ApiKeyRevokedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ApiKeyRevokedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApiKeyRevokedProperties>(create);
  static ApiKeyRevokedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get apiKeyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set apiKeyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApiKeyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApiKeyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

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
