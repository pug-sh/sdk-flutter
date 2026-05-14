// This is a generated file - do not edit.
//
// Generated from common/v1/property_value.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum PropertyValue_Value {
  stringValue,
  intValue,
  doubleValue,
  boolValue,
  timestampValue,
  notSet
}

/// PropertyValue is the typed value of an event property.
/// Exactly one variant must be set; this is enforced by the protovalidate
/// oneof.required option below.
///
/// Lists, objects, and other compound types are intentionally not included
/// in this iteration — only the five primitive types supported by the
/// ClickHouse Variant storage target. New variants can be added later as
/// additive oneof entries (wire-compatible).
class PropertyValue extends $pb.GeneratedMessage {
  factory PropertyValue({
    $core.String? stringValue,
    $fixnum.Int64? intValue,
    $core.double? doubleValue,
    $core.bool? boolValue,
    $0.Timestamp? timestampValue,
  }) {
    final result = create();
    if (stringValue != null) result.stringValue = stringValue;
    if (intValue != null) result.intValue = intValue;
    if (doubleValue != null) result.doubleValue = doubleValue;
    if (boolValue != null) result.boolValue = boolValue;
    if (timestampValue != null) result.timestampValue = timestampValue;
    return result;
  }

  PropertyValue._();

  factory PropertyValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PropertyValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, PropertyValue_Value>
      _PropertyValue_ValueByTag = {
    1: PropertyValue_Value.stringValue,
    2: PropertyValue_Value.intValue,
    3: PropertyValue_Value.doubleValue,
    4: PropertyValue_Value.boolValue,
    5: PropertyValue_Value.timestampValue,
    0: PropertyValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PropertyValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOS(1, _omitFieldNames ? '' : 'stringValue')
    ..aInt64(2, _omitFieldNames ? '' : 'intValue')
    ..aD(3, _omitFieldNames ? '' : 'doubleValue')
    ..aOB(4, _omitFieldNames ? '' : 'boolValue')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'timestampValue',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PropertyValue clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PropertyValue copyWith(void Function(PropertyValue) updates) =>
      super.copyWith((message) => updates(message as PropertyValue))
          as PropertyValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PropertyValue create() => PropertyValue._();
  @$core.override
  PropertyValue createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PropertyValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PropertyValue>(create);
  static PropertyValue? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  PropertyValue_Value whichValue() =>
      _PropertyValue_ValueByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearValue() => $_clearField($_whichOneof(0));

  /// Cap property string values at 1024 Unicode codepoints. Large blobs
  /// (logs, raw payloads, serialized JSON) should be hashed or referenced
  /// upstream rather than embedded as a property value. Note: max_len
  /// counts codepoints, not bytes — multi-byte UTF-8 (emoji, CJK) can
  /// exceed 1 KiB on the wire at this limit. Switch to max_bytes if a
  /// hard byte cap is required. Values exceeding the limit are rejected
  /// at the validate interceptor with CodeInvalidArgument (not truncated).
  ///
  /// Empty-string note: the filter expression cannot distinguish a
  /// custom_properties value of "" from an absent key — both project to ''
  /// in propertyExpr (filters.go), so EQUALS '' and IS_NOT_SET match
  /// identically. If the empty case is meaningful, encode it differently
  /// (e.g. a sentinel value) on the producer side.
  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get intValue => $_getI64(1);
  @$pb.TagNumber(2)
  set intValue($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIntValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get doubleValue => $_getN(2);
  @$pb.TagNumber(3)
  set doubleValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDoubleValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get boolValue => $_getBF(3);
  @$pb.TagNumber(4)
  set boolValue($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBoolValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoolValue() => $_clearField(4);

  /// Stored as a DateTime64(3) Variant slot. Sub-millisecond precision is
  /// truncated by ClickHouse on insert to match the slot's precision; no
  /// Go-side truncation is performed in the worker.
  @$pb.TagNumber(5)
  $0.Timestamp get timestampValue => $_getN(4);
  @$pb.TagNumber(5)
  set timestampValue($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestampValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestampValue() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureTimestampValue() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
