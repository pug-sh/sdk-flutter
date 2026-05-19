// This is a generated file - do not edit.
//
// Generated from common/events/v1/notification_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class NotificationReceivedProperties extends $pb.GeneratedMessage {
  factory NotificationReceivedProperties({
    $core.String? campaignId,
    $core.String? notificationType,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (notificationType != null) result.notificationType = notificationType;
    return result;
  }

  NotificationReceivedProperties._();

  factory NotificationReceivedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationReceivedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationReceivedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..aOS(2, _omitFieldNames ? '' : 'notificationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationReceivedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationReceivedProperties copyWith(
          void Function(NotificationReceivedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationReceivedProperties))
          as NotificationReceivedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationReceivedProperties create() =>
      NotificationReceivedProperties._();
  @$core.override
  NotificationReceivedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NotificationReceivedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationReceivedProperties>(create);
  static NotificationReceivedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get notificationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set notificationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNotificationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearNotificationType() => $_clearField(2);
}

class NotificationClickedProperties extends $pb.GeneratedMessage {
  factory NotificationClickedProperties({
    $core.String? campaignId,
    $core.String? notificationType,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (notificationType != null) result.notificationType = notificationType;
    return result;
  }

  NotificationClickedProperties._();

  factory NotificationClickedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationClickedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationClickedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..aOS(2, _omitFieldNames ? '' : 'notificationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationClickedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationClickedProperties copyWith(
          void Function(NotificationClickedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationClickedProperties))
          as NotificationClickedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationClickedProperties create() =>
      NotificationClickedProperties._();
  @$core.override
  NotificationClickedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NotificationClickedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationClickedProperties>(create);
  static NotificationClickedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get notificationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set notificationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNotificationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearNotificationType() => $_clearField(2);
}

class NotificationDismissedProperties extends $pb.GeneratedMessage {
  factory NotificationDismissedProperties({
    $core.String? campaignId,
    $core.String? notificationType,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (notificationType != null) result.notificationType = notificationType;
    return result;
  }

  NotificationDismissedProperties._();

  factory NotificationDismissedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationDismissedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationDismissedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..aOS(2, _omitFieldNames ? '' : 'notificationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationDismissedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationDismissedProperties copyWith(
          void Function(NotificationDismissedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as NotificationDismissedProperties))
          as NotificationDismissedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationDismissedProperties create() =>
      NotificationDismissedProperties._();
  @$core.override
  NotificationDismissedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NotificationDismissedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationDismissedProperties>(
          create);
  static NotificationDismissedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get notificationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set notificationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNotificationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearNotificationType() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
