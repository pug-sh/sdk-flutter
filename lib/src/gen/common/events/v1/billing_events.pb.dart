// This is a generated file - do not edit.
//
// Generated from common/events/v1/billing_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SubscriptionStartedProperties extends $pb.GeneratedMessage {
  factory SubscriptionStartedProperties({
    $core.String? subscriptionId,
    $core.String? planId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  SubscriptionStartedProperties._();

  factory SubscriptionStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aD(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionStartedProperties copyWith(
          void Function(SubscriptionStartedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SubscriptionStartedProperties))
          as SubscriptionStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionStartedProperties create() =>
      SubscriptionStartedProperties._();
  @$core.override
  SubscriptionStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionStartedProperties>(create);
  static SubscriptionStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);
}

class SubscriptionChangedProperties extends $pb.GeneratedMessage {
  factory SubscriptionChangedProperties({
    $core.String? subscriptionId,
    $core.String? previousPlanId,
    $core.String? newPlanId,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (previousPlanId != null) result.previousPlanId = previousPlanId;
    if (newPlanId != null) result.newPlanId = newPlanId;
    return result;
  }

  SubscriptionChangedProperties._();

  factory SubscriptionChangedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionChangedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionChangedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'previousPlanId')
    ..aOS(3, _omitFieldNames ? '' : 'newPlanId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionChangedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionChangedProperties copyWith(
          void Function(SubscriptionChangedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SubscriptionChangedProperties))
          as SubscriptionChangedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionChangedProperties create() =>
      SubscriptionChangedProperties._();
  @$core.override
  SubscriptionChangedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionChangedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionChangedProperties>(create);
  static SubscriptionChangedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get previousPlanId => $_getSZ(1);
  @$pb.TagNumber(2)
  set previousPlanId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreviousPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviousPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get newPlanId => $_getSZ(2);
  @$pb.TagNumber(3)
  set newPlanId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewPlanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewPlanId() => $_clearField(3);
}

class SubscriptionCanceledProperties extends $pb.GeneratedMessage {
  factory SubscriptionCanceledProperties({
    $core.String? subscriptionId,
    $core.String? planId,
    $core.String? reason,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    if (reason != null) result.reason = reason;
    return result;
  }

  SubscriptionCanceledProperties._();

  factory SubscriptionCanceledProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionCanceledProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionCanceledProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionCanceledProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionCanceledProperties copyWith(
          void Function(SubscriptionCanceledProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SubscriptionCanceledProperties))
          as SubscriptionCanceledProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionCanceledProperties create() =>
      SubscriptionCanceledProperties._();
  @$core.override
  SubscriptionCanceledProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionCanceledProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionCanceledProperties>(create);
  static SubscriptionCanceledProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class SubscriptionRenewedProperties extends $pb.GeneratedMessage {
  factory SubscriptionRenewedProperties({
    $core.String? subscriptionId,
    $core.String? planId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  SubscriptionRenewedProperties._();

  factory SubscriptionRenewedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionRenewedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionRenewedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aD(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionRenewedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionRenewedProperties copyWith(
          void Function(SubscriptionRenewedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SubscriptionRenewedProperties))
          as SubscriptionRenewedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionRenewedProperties create() =>
      SubscriptionRenewedProperties._();
  @$core.override
  SubscriptionRenewedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionRenewedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionRenewedProperties>(create);
  static SubscriptionRenewedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);
}

class SubscriptionPausedProperties extends $pb.GeneratedMessage {
  factory SubscriptionPausedProperties({
    $core.String? subscriptionId,
    $core.String? planId,
    $core.String? reason,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    if (reason != null) result.reason = reason;
    return result;
  }

  SubscriptionPausedProperties._();

  factory SubscriptionPausedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionPausedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionPausedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionPausedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionPausedProperties copyWith(
          void Function(SubscriptionPausedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SubscriptionPausedProperties))
          as SubscriptionPausedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionPausedProperties create() =>
      SubscriptionPausedProperties._();
  @$core.override
  SubscriptionPausedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionPausedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionPausedProperties>(create);
  static SubscriptionPausedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class SubscriptionResumedProperties extends $pb.GeneratedMessage {
  factory SubscriptionResumedProperties({
    $core.String? subscriptionId,
    $core.String? planId,
    $core.String? reason,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    if (reason != null) result.reason = reason;
    return result;
  }

  SubscriptionResumedProperties._();

  factory SubscriptionResumedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionResumedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionResumedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionResumedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionResumedProperties copyWith(
          void Function(SubscriptionResumedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SubscriptionResumedProperties))
          as SubscriptionResumedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionResumedProperties create() =>
      SubscriptionResumedProperties._();
  @$core.override
  SubscriptionResumedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionResumedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionResumedProperties>(create);
  static SubscriptionResumedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

/// Fired in advance of a trial converting (e.g. 3 days before). Useful for
/// upsell / conversion campaigns.
class SubscriptionTrialWillEndProperties extends $pb.GeneratedMessage {
  factory SubscriptionTrialWillEndProperties({
    $core.String? subscriptionId,
    $core.String? planId,
    $core.String? trialId,
  }) {
    final result = create();
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    if (trialId != null) result.trialId = trialId;
    return result;
  }

  SubscriptionTrialWillEndProperties._();

  factory SubscriptionTrialWillEndProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscriptionTrialWillEndProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscriptionTrialWillEndProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aOS(3, _omitFieldNames ? '' : 'trialId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionTrialWillEndProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscriptionTrialWillEndProperties copyWith(
          void Function(SubscriptionTrialWillEndProperties) updates) =>
      super.copyWith((message) =>
              updates(message as SubscriptionTrialWillEndProperties))
          as SubscriptionTrialWillEndProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscriptionTrialWillEndProperties create() =>
      SubscriptionTrialWillEndProperties._();
  @$core.override
  SubscriptionTrialWillEndProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscriptionTrialWillEndProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscriptionTrialWillEndProperties>(
          create);
  static SubscriptionTrialWillEndProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subscriptionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subscriptionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubscriptionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubscriptionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get trialId => $_getSZ(2);
  @$pb.TagNumber(3)
  set trialId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTrialId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrialId() => $_clearField(3);
}

class InvoicePaidProperties extends $pb.GeneratedMessage {
  factory InvoicePaidProperties({
    $core.String? invoiceId,
    $core.String? subscriptionId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  InvoicePaidProperties._();

  factory InvoicePaidProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvoicePaidProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvoicePaidProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'subscriptionId')
    ..aD(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoicePaidProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoicePaidProperties copyWith(
          void Function(InvoicePaidProperties) updates) =>
      super.copyWith((message) => updates(message as InvoicePaidProperties))
          as InvoicePaidProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoicePaidProperties create() => InvoicePaidProperties._();
  @$core.override
  InvoicePaidProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InvoicePaidProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvoicePaidProperties>(create);
  static InvoicePaidProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get subscriptionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set subscriptionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscriptionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);
}

class InvoiceFailedProperties extends $pb.GeneratedMessage {
  factory InvoiceFailedProperties({
    $core.String? invoiceId,
    $core.String? subscriptionId,
    $core.double? amount,
    $core.String? currency,
    $core.String? reason,
  }) {
    final result = create();
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (reason != null) result.reason = reason;
    return result;
  }

  InvoiceFailedProperties._();

  factory InvoiceFailedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvoiceFailedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvoiceFailedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(2, _omitFieldNames ? '' : 'subscriptionId')
    ..aD(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoiceFailedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvoiceFailedProperties copyWith(
          void Function(InvoiceFailedProperties) updates) =>
      super.copyWith((message) => updates(message as InvoiceFailedProperties))
          as InvoiceFailedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceFailedProperties create() => InvoiceFailedProperties._();
  @$core.override
  InvoiceFailedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InvoiceFailedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvoiceFailedProperties>(create);
  static InvoiceFailedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvoiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get subscriptionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set subscriptionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscriptionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => $_clearField(5);
}

class PaymentSucceededProperties extends $pb.GeneratedMessage {
  factory PaymentSucceededProperties({
    $core.String? paymentId,
    $core.String? invoiceId,
    $core.String? subscriptionId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  PaymentSucceededProperties._();

  factory PaymentSucceededProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentSucceededProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentSucceededProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'subscriptionId')
    ..aD(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentSucceededProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentSucceededProperties copyWith(
          void Function(PaymentSucceededProperties) updates) =>
      super.copyWith(
              (message) => updates(message as PaymentSucceededProperties))
          as PaymentSucceededProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentSucceededProperties create() => PaymentSucceededProperties._();
  @$core.override
  PaymentSucceededProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaymentSucceededProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentSucceededProperties>(create);
  static PaymentSucceededProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get subscriptionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set subscriptionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubscriptionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscriptionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);
}

class PaymentFailedProperties extends $pb.GeneratedMessage {
  factory PaymentFailedProperties({
    $core.String? paymentId,
    $core.String? invoiceId,
    $core.String? subscriptionId,
    $core.double? amount,
    $core.String? currency,
    $core.String? reason,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    if (invoiceId != null) result.invoiceId = invoiceId;
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (reason != null) result.reason = reason;
    return result;
  }

  PaymentFailedProperties._();

  factory PaymentFailedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentFailedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentFailedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'invoiceId')
    ..aOS(3, _omitFieldNames ? '' : 'subscriptionId')
    ..aD(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentFailedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentFailedProperties copyWith(
          void Function(PaymentFailedProperties) updates) =>
      super.copyWith((message) => updates(message as PaymentFailedProperties))
          as PaymentFailedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentFailedProperties create() => PaymentFailedProperties._();
  @$core.override
  PaymentFailedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaymentFailedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentFailedProperties>(create);
  static PaymentFailedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get invoiceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set invoiceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvoiceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get subscriptionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set subscriptionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubscriptionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscriptionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reason => $_getSZ(5);
  @$pb.TagNumber(6)
  set reason($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearReason() => $_clearField(6);
}

class PaymentMethodAddedProperties extends $pb.GeneratedMessage {
  factory PaymentMethodAddedProperties({
    $core.String? paymentMethodId,
    $core.String? paymentMethodType,
  }) {
    final result = create();
    if (paymentMethodId != null) result.paymentMethodId = paymentMethodId;
    if (paymentMethodType != null) result.paymentMethodType = paymentMethodType;
    return result;
  }

  PaymentMethodAddedProperties._();

  factory PaymentMethodAddedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentMethodAddedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentMethodAddedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentMethodId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethodType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentMethodAddedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentMethodAddedProperties copyWith(
          void Function(PaymentMethodAddedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as PaymentMethodAddedProperties))
          as PaymentMethodAddedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentMethodAddedProperties create() =>
      PaymentMethodAddedProperties._();
  @$core.override
  PaymentMethodAddedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaymentMethodAddedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentMethodAddedProperties>(create);
  static PaymentMethodAddedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentMethodId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentMethodId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentMethodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentMethodId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethodType => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethodType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethodType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethodType() => $_clearField(2);
}

class PaymentMethodRemovedProperties extends $pb.GeneratedMessage {
  factory PaymentMethodRemovedProperties({
    $core.String? paymentMethodId,
    $core.String? paymentMethodType,
  }) {
    final result = create();
    if (paymentMethodId != null) result.paymentMethodId = paymentMethodId;
    if (paymentMethodType != null) result.paymentMethodType = paymentMethodType;
    return result;
  }

  PaymentMethodRemovedProperties._();

  factory PaymentMethodRemovedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentMethodRemovedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentMethodRemovedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentMethodId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethodType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentMethodRemovedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentMethodRemovedProperties copyWith(
          void Function(PaymentMethodRemovedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as PaymentMethodRemovedProperties))
          as PaymentMethodRemovedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentMethodRemovedProperties create() =>
      PaymentMethodRemovedProperties._();
  @$core.override
  PaymentMethodRemovedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaymentMethodRemovedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentMethodRemovedProperties>(create);
  static PaymentMethodRemovedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentMethodId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentMethodId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentMethodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentMethodId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethodType => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethodType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethodType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethodType() => $_clearField(2);
}

class TrialStartedProperties extends $pb.GeneratedMessage {
  factory TrialStartedProperties({
    $core.String? trialId,
    $core.String? planId,
  }) {
    final result = create();
    if (trialId != null) result.trialId = trialId;
    if (planId != null) result.planId = planId;
    return result;
  }

  TrialStartedProperties._();

  factory TrialStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrialStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrialStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trialId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrialStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrialStartedProperties copyWith(
          void Function(TrialStartedProperties) updates) =>
      super.copyWith((message) => updates(message as TrialStartedProperties))
          as TrialStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrialStartedProperties create() => TrialStartedProperties._();
  @$core.override
  TrialStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrialStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrialStartedProperties>(create);
  static TrialStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trialId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trialId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrialId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrialId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);
}

class TrialConvertedProperties extends $pb.GeneratedMessage {
  factory TrialConvertedProperties({
    $core.String? trialId,
    $core.String? subscriptionId,
    $core.String? planId,
  }) {
    final result = create();
    if (trialId != null) result.trialId = trialId;
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (planId != null) result.planId = planId;
    return result;
  }

  TrialConvertedProperties._();

  factory TrialConvertedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrialConvertedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrialConvertedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trialId')
    ..aOS(2, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(3, _omitFieldNames ? '' : 'planId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrialConvertedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrialConvertedProperties copyWith(
          void Function(TrialConvertedProperties) updates) =>
      super.copyWith((message) => updates(message as TrialConvertedProperties))
          as TrialConvertedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrialConvertedProperties create() => TrialConvertedProperties._();
  @$core.override
  TrialConvertedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrialConvertedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrialConvertedProperties>(create);
  static TrialConvertedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trialId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trialId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrialId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrialId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get subscriptionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set subscriptionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSubscriptionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get planId => $_getSZ(2);
  @$pb.TagNumber(3)
  set planId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPlanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlanId() => $_clearField(3);
}

class RefundFailedProperties extends $pb.GeneratedMessage {
  factory RefundFailedProperties({
    $core.String? orderId,
    $core.String? refundId,
    $core.double? amount,
    $core.String? currency,
    $core.String? reason,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (refundId != null) result.refundId = refundId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (reason != null) result.reason = reason;
    return result;
  }

  RefundFailedProperties._();

  factory RefundFailedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefundFailedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefundFailedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aOS(2, _omitFieldNames ? '' : 'refundId')
    ..aD(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundFailedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefundFailedProperties copyWith(
          void Function(RefundFailedProperties) updates) =>
      super.copyWith((message) => updates(message as RefundFailedProperties))
          as RefundFailedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefundFailedProperties create() => RefundFailedProperties._();
  @$core.override
  RefundFailedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RefundFailedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefundFailedProperties>(create);
  static RefundFailedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refundId => $_getSZ(1);
  @$pb.TagNumber(2)
  set refundId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefundId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefundId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
