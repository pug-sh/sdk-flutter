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

import 'options.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'options.pbenum.dart';

class Options {
  static final kind = $pb.Extension<$core.String>(
      _omitMessageNames ? '' : 'google.protobuf.MessageOptions',
      _omitFieldNames ? '' : 'kind',
      50000,
      $pb.PbFieldType.OS);
  static final pii = $pb.Extension<$core.bool>(
      _omitMessageNames ? '' : 'google.protobuf.FieldOptions',
      _omitFieldNames ? '' : 'pii',
      50001,
      $pb.PbFieldType.OB);
  static final platforms = $pb.Extension<Platform>.repeated(
      _omitMessageNames ? '' : 'google.protobuf.MessageOptions',
      _omitFieldNames ? '' : 'platforms',
      50002,
      $pb.PbFieldType.KE,
      check: $pb.getCheckFunction($pb.PbFieldType.KE),
      valueOf: Platform.valueOf,
      enumValues: Platform.values);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(kind);
    registry.add(pii);
    registry.add(platforms);
  }
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
