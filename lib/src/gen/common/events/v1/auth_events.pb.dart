// This is a generated file - do not edit.
//
// Generated from common/events/v1/auth_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SignupProperties extends $pb.GeneratedMessage {
  factory SignupProperties() => create();

  SignupProperties._();

  factory SignupProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignupProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupProperties copyWith(void Function(SignupProperties) updates) =>
      super.copyWith((message) => updates(message as SignupProperties))
          as SignupProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupProperties create() => SignupProperties._();
  @$core.override
  SignupProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignupProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupProperties>(create);
  static SignupProperties? _defaultInstance;
}

class SigninProperties extends $pb.GeneratedMessage {
  factory SigninProperties() => create();

  SigninProperties._();

  factory SigninProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SigninProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SigninProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SigninProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SigninProperties copyWith(void Function(SigninProperties) updates) =>
      super.copyWith((message) => updates(message as SigninProperties))
          as SigninProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SigninProperties create() => SigninProperties._();
  @$core.override
  SigninProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SigninProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SigninProperties>(create);
  static SigninProperties? _defaultInstance;
}

class SignoutProperties extends $pb.GeneratedMessage {
  factory SignoutProperties() => create();

  SignoutProperties._();

  factory SignoutProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignoutProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignoutProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignoutProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignoutProperties copyWith(void Function(SignoutProperties) updates) =>
      super.copyWith((message) => updates(message as SignoutProperties))
          as SignoutProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignoutProperties create() => SignoutProperties._();
  @$core.override
  SignoutProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignoutProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignoutProperties>(create);
  static SignoutProperties? _defaultInstance;
}

class EmailVerifiedProperties extends $pb.GeneratedMessage {
  factory EmailVerifiedProperties() => create();

  EmailVerifiedProperties._();

  factory EmailVerifiedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EmailVerifiedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmailVerifiedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmailVerifiedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmailVerifiedProperties copyWith(
          void Function(EmailVerifiedProperties) updates) =>
      super.copyWith((message) => updates(message as EmailVerifiedProperties))
          as EmailVerifiedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailVerifiedProperties create() => EmailVerifiedProperties._();
  @$core.override
  EmailVerifiedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EmailVerifiedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EmailVerifiedProperties>(create);
  static EmailVerifiedProperties? _defaultInstance;
}

class PasswordResetRequestedProperties extends $pb.GeneratedMessage {
  factory PasswordResetRequestedProperties() => create();

  PasswordResetRequestedProperties._();

  factory PasswordResetRequestedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PasswordResetRequestedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PasswordResetRequestedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasswordResetRequestedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasswordResetRequestedProperties copyWith(
          void Function(PasswordResetRequestedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as PasswordResetRequestedProperties))
          as PasswordResetRequestedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PasswordResetRequestedProperties create() =>
      PasswordResetRequestedProperties._();
  @$core.override
  PasswordResetRequestedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PasswordResetRequestedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PasswordResetRequestedProperties>(
          create);
  static PasswordResetRequestedProperties? _defaultInstance;
}

class PasswordResetCompletedProperties extends $pb.GeneratedMessage {
  factory PasswordResetCompletedProperties() => create();

  PasswordResetCompletedProperties._();

  factory PasswordResetCompletedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PasswordResetCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PasswordResetCompletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasswordResetCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasswordResetCompletedProperties copyWith(
          void Function(PasswordResetCompletedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as PasswordResetCompletedProperties))
          as PasswordResetCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PasswordResetCompletedProperties create() =>
      PasswordResetCompletedProperties._();
  @$core.override
  PasswordResetCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PasswordResetCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PasswordResetCompletedProperties>(
          create);
  static PasswordResetCompletedProperties? _defaultInstance;
}

/// Common method values: "totp", "sms", "email", "webauthn", "backup_codes".
class MfaEnabledProperties extends $pb.GeneratedMessage {
  factory MfaEnabledProperties({
    $core.String? method,
  }) {
    final result = create();
    if (method != null) result.method = method;
    return result;
  }

  MfaEnabledProperties._();

  factory MfaEnabledProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MfaEnabledProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MfaEnabledProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'method')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MfaEnabledProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MfaEnabledProperties copyWith(void Function(MfaEnabledProperties) updates) =>
      super.copyWith((message) => updates(message as MfaEnabledProperties))
          as MfaEnabledProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MfaEnabledProperties create() => MfaEnabledProperties._();
  @$core.override
  MfaEnabledProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MfaEnabledProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MfaEnabledProperties>(create);
  static MfaEnabledProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => $_clearField(1);
}

/// Common method values: "totp", "sms", "email", "webauthn", "backup_codes".
class MfaDisabledProperties extends $pb.GeneratedMessage {
  factory MfaDisabledProperties({
    $core.String? method,
  }) {
    final result = create();
    if (method != null) result.method = method;
    return result;
  }

  MfaDisabledProperties._();

  factory MfaDisabledProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MfaDisabledProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MfaDisabledProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'method')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MfaDisabledProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MfaDisabledProperties copyWith(
          void Function(MfaDisabledProperties) updates) =>
      super.copyWith((message) => updates(message as MfaDisabledProperties))
          as MfaDisabledProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MfaDisabledProperties create() => MfaDisabledProperties._();
  @$core.override
  MfaDisabledProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MfaDisabledProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MfaDisabledProperties>(create);
  static MfaDisabledProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
