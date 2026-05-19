// This is a generated file - do not edit.
//
// Generated from common/events/v1/app_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class AppOpenProperties extends $pb.GeneratedMessage {
  factory AppOpenProperties() => create();

  AppOpenProperties._();

  factory AppOpenProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppOpenProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppOpenProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppOpenProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppOpenProperties copyWith(void Function(AppOpenProperties) updates) =>
      super.copyWith((message) => updates(message as AppOpenProperties))
          as AppOpenProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppOpenProperties create() => AppOpenProperties._();
  @$core.override
  AppOpenProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppOpenProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppOpenProperties>(create);
  static AppOpenProperties? _defaultInstance;
}

class AppCloseProperties extends $pb.GeneratedMessage {
  factory AppCloseProperties() => create();

  AppCloseProperties._();

  factory AppCloseProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppCloseProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppCloseProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppCloseProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppCloseProperties copyWith(void Function(AppCloseProperties) updates) =>
      super.copyWith((message) => updates(message as AppCloseProperties))
          as AppCloseProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppCloseProperties create() => AppCloseProperties._();
  @$core.override
  AppCloseProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppCloseProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppCloseProperties>(create);
  static AppCloseProperties? _defaultInstance;
}

/// First-launch / fresh-install signal. Typically fires once per install.
class AppInstallProperties extends $pb.GeneratedMessage {
  factory AppInstallProperties({
    $core.String? appVersion,
    $core.String? installSource,
  }) {
    final result = create();
    if (appVersion != null) result.appVersion = appVersion;
    if (installSource != null) result.installSource = installSource;
    return result;
  }

  AppInstallProperties._();

  factory AppInstallProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppInstallProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppInstallProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'appVersion')
    ..aOS(2, _omitFieldNames ? '' : 'installSource')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppInstallProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppInstallProperties copyWith(void Function(AppInstallProperties) updates) =>
      super.copyWith((message) => updates(message as AppInstallProperties))
          as AppInstallProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppInstallProperties create() => AppInstallProperties._();
  @$core.override
  AppInstallProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppInstallProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppInstallProperties>(create);
  static AppInstallProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get appVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set appVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAppVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get installSource => $_getSZ(1);
  @$pb.TagNumber(2)
  set installSource($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInstallSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearInstallSource() => $_clearField(2);
}

/// Fires the first time the app launches after an update.
class AppUpdateProperties extends $pb.GeneratedMessage {
  factory AppUpdateProperties({
    $core.String? appVersion,
    $core.String? previousVersion,
  }) {
    final result = create();
    if (appVersion != null) result.appVersion = appVersion;
    if (previousVersion != null) result.previousVersion = previousVersion;
    return result;
  }

  AppUpdateProperties._();

  factory AppUpdateProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppUpdateProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppUpdateProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'appVersion')
    ..aOS(2, _omitFieldNames ? '' : 'previousVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppUpdateProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppUpdateProperties copyWith(void Function(AppUpdateProperties) updates) =>
      super.copyWith((message) => updates(message as AppUpdateProperties))
          as AppUpdateProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppUpdateProperties create() => AppUpdateProperties._();
  @$core.override
  AppUpdateProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppUpdateProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppUpdateProperties>(create);
  static AppUpdateProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get appVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set appVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAppVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get previousVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set previousVersion($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreviousVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviousVersion() => $_clearField(2);
}

/// App moved to the background (lifecycle distinct from app_close).
class AppBackgroundedProperties extends $pb.GeneratedMessage {
  factory AppBackgroundedProperties() => create();

  AppBackgroundedProperties._();

  factory AppBackgroundedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppBackgroundedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppBackgroundedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppBackgroundedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppBackgroundedProperties copyWith(
          void Function(AppBackgroundedProperties) updates) =>
      super.copyWith((message) => updates(message as AppBackgroundedProperties))
          as AppBackgroundedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppBackgroundedProperties create() => AppBackgroundedProperties._();
  @$core.override
  AppBackgroundedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppBackgroundedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppBackgroundedProperties>(create);
  static AppBackgroundedProperties? _defaultInstance;
}

/// App returned to the foreground from the background.
class AppForegroundedProperties extends $pb.GeneratedMessage {
  factory AppForegroundedProperties() => create();

  AppForegroundedProperties._();

  factory AppForegroundedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppForegroundedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppForegroundedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppForegroundedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppForegroundedProperties copyWith(
          void Function(AppForegroundedProperties) updates) =>
      super.copyWith((message) => updates(message as AppForegroundedProperties))
          as AppForegroundedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppForegroundedProperties create() => AppForegroundedProperties._();
  @$core.override
  AppForegroundedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppForegroundedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppForegroundedProperties>(create);
  static AppForegroundedProperties? _defaultInstance;
}

class AppCrashedProperties extends $pb.GeneratedMessage {
  factory AppCrashedProperties({
    $core.String? errorMessage,
    $core.String? errorType,
  }) {
    final result = create();
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (errorType != null) result.errorType = errorType;
    return result;
  }

  AppCrashedProperties._();

  factory AppCrashedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AppCrashedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AppCrashedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(2, _omitFieldNames ? '' : 'errorType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppCrashedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AppCrashedProperties copyWith(void Function(AppCrashedProperties) updates) =>
      super.copyWith((message) => updates(message as AppCrashedProperties))
          as AppCrashedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AppCrashedProperties create() => AppCrashedProperties._();
  @$core.override
  AppCrashedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AppCrashedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AppCrashedProperties>(create);
  static AppCrashedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get errorMessage => $_getSZ(0);
  @$pb.TagNumber(1)
  set errorMessage($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasErrorMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrorMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorType => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorType() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorType() => $_clearField(2);
}

class FeatureUsedProperties extends $pb.GeneratedMessage {
  factory FeatureUsedProperties({
    $core.String? featureId,
    $core.String? featureName,
  }) {
    final result = create();
    if (featureId != null) result.featureId = featureId;
    if (featureName != null) result.featureName = featureName;
    return result;
  }

  FeatureUsedProperties._();

  factory FeatureUsedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeatureUsedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeatureUsedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'featureId')
    ..aOS(2, _omitFieldNames ? '' : 'featureName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeatureUsedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeatureUsedProperties copyWith(
          void Function(FeatureUsedProperties) updates) =>
      super.copyWith((message) => updates(message as FeatureUsedProperties))
          as FeatureUsedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeatureUsedProperties create() => FeatureUsedProperties._();
  @$core.override
  FeatureUsedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FeatureUsedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeatureUsedProperties>(create);
  static FeatureUsedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get featureId => $_getSZ(0);
  @$pb.TagNumber(1)
  set featureId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFeatureId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeatureId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get featureName => $_getSZ(1);
  @$pb.TagNumber(2)
  set featureName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFeatureName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeatureName() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
