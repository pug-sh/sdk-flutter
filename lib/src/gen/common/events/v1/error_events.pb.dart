// This is a generated file - do not edit.
//
// Generated from common/events/v1/error_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Common severity values: "info", "warning", "error", "fatal".
/// unhandled indicates whether the error was caught by application code (false)
/// or escaped to a global handler / crashed the surface (true).
class ErrorOccurredProperties extends $pb.GeneratedMessage {
  factory ErrorOccurredProperties({
    $core.String? errorCode,
    $core.String? message,
    $core.String? severity,
    $core.bool? unhandled,
    $core.String? stack,
  }) {
    final result = create();
    if (errorCode != null) result.errorCode = errorCode;
    if (message != null) result.message = message;
    if (severity != null) result.severity = severity;
    if (unhandled != null) result.unhandled = unhandled;
    if (stack != null) result.stack = stack;
    return result;
  }

  ErrorOccurredProperties._();

  factory ErrorOccurredProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ErrorOccurredProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ErrorOccurredProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'errorCode')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'severity')
    ..aOB(4, _omitFieldNames ? '' : 'unhandled')
    ..aOS(5, _omitFieldNames ? '' : 'stack')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorOccurredProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ErrorOccurredProperties copyWith(
          void Function(ErrorOccurredProperties) updates) =>
      super.copyWith((message) => updates(message as ErrorOccurredProperties))
          as ErrorOccurredProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorOccurredProperties create() => ErrorOccurredProperties._();
  @$core.override
  ErrorOccurredProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ErrorOccurredProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ErrorOccurredProperties>(create);
  static ErrorOccurredProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get errorCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set errorCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasErrorCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrorCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get severity => $_getSZ(2);
  @$pb.TagNumber(3)
  set severity($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSeverity() => $_has(2);
  @$pb.TagNumber(3)
  void clearSeverity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get unhandled => $_getBF(3);
  @$pb.TagNumber(4)
  set unhandled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnhandled() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnhandled() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get stack => $_getSZ(4);
  @$pb.TagNumber(5)
  set stack($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStack() => $_has(4);
  @$pb.TagNumber(5)
  void clearStack() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
