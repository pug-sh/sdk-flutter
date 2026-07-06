// This is a generated file - do not edit.
//
// Generated from common/events/v1/options.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Platform identifies the client/runtime an event is intended for.
/// Used by SDK codegen tooling to decide which language targets should
/// surface a given well-known event. Like `kind`, this is an SDK hint —
/// the server does not enforce it.
///
/// Naming note: a separate `Platform` enum exists in
/// `shared/delivery/v1/delivery.proto` for push-notification transport
/// targets (ANDROID/IOS only). The two enums describe different concepts
/// (event source vs push transport) and intentionally coexist; in Go
/// they are `commoneventsv1.Platform` vs `deliveryv1.Platform`. Their
/// ordinal integers are independent — do not assume a value name shared
/// between them encodes to the same wire integer in both packages.
class Platform extends $pb.ProtobufEnum {
  static const Platform PLATFORM_UNSPECIFIED =
      Platform._(0, _omitEnumNames ? '' : 'PLATFORM_UNSPECIFIED');
  static const Platform PLATFORM_WEB =
      Platform._(1, _omitEnumNames ? '' : 'PLATFORM_WEB');
  static const Platform PLATFORM_IOS =
      Platform._(2, _omitEnumNames ? '' : 'PLATFORM_IOS');
  static const Platform PLATFORM_ANDROID =
      Platform._(3, _omitEnumNames ? '' : 'PLATFORM_ANDROID');
  static const Platform PLATFORM_DESKTOP =
      Platform._(4, _omitEnumNames ? '' : 'PLATFORM_DESKTOP');
  static const Platform PLATFORM_SERVER =
      Platform._(5, _omitEnumNames ? '' : 'PLATFORM_SERVER');

  static const $core.List<Platform> values = <Platform>[
    PLATFORM_UNSPECIFIED,
    PLATFORM_WEB,
    PLATFORM_IOS,
    PLATFORM_ANDROID,
    PLATFORM_DESKTOP,
    PLATFORM_SERVER,
  ];

  static final $core.List<Platform?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static Platform? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Platform._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
