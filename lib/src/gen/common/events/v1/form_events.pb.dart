// This is a generated file - do not edit.
//
// Generated from common/events/v1/form_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FormStartProperties extends $pb.GeneratedMessage {
  factory FormStartProperties({
    $core.String? formId,
    $core.String? formName,
  }) {
    final result = create();
    if (formId != null) result.formId = formId;
    if (formName != null) result.formName = formName;
    return result;
  }

  FormStartProperties._();

  factory FormStartProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FormStartProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FormStartProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'formId')
    ..aOS(2, _omitFieldNames ? '' : 'formName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormStartProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormStartProperties copyWith(void Function(FormStartProperties) updates) =>
      super.copyWith((message) => updates(message as FormStartProperties))
          as FormStartProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FormStartProperties create() => FormStartProperties._();
  @$core.override
  FormStartProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FormStartProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FormStartProperties>(create);
  static FormStartProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get formId => $_getSZ(0);
  @$pb.TagNumber(1)
  set formId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFormId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFormId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get formName => $_getSZ(1);
  @$pb.TagNumber(2)
  set formName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFormName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormName() => $_clearField(2);
}

class FormSubmitProperties extends $pb.GeneratedMessage {
  factory FormSubmitProperties({
    $core.String? formId,
    $core.String? formName,
    $core.String? action,
  }) {
    final result = create();
    if (formId != null) result.formId = formId;
    if (formName != null) result.formName = formName;
    if (action != null) result.action = action;
    return result;
  }

  FormSubmitProperties._();

  factory FormSubmitProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FormSubmitProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FormSubmitProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'formId')
    ..aOS(2, _omitFieldNames ? '' : 'formName')
    ..aOS(3, _omitFieldNames ? '' : 'action')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormSubmitProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormSubmitProperties copyWith(void Function(FormSubmitProperties) updates) =>
      super.copyWith((message) => updates(message as FormSubmitProperties))
          as FormSubmitProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FormSubmitProperties create() => FormSubmitProperties._();
  @$core.override
  FormSubmitProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FormSubmitProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FormSubmitProperties>(create);
  static FormSubmitProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get formId => $_getSZ(0);
  @$pb.TagNumber(1)
  set formId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFormId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFormId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get formName => $_getSZ(1);
  @$pb.TagNumber(2)
  set formName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFormName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get action => $_getSZ(2);
  @$pb.TagNumber(3)
  set action($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearAction() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
