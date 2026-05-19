// This is a generated file - do not edit.
//
// Generated from common/events/v1/navigation_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Web page navigation. Use screen_view for native mobile screens.
///
/// Page URL, title, referrer, and UTM parameters are provided by SDK-injected
/// auto-properties ($url, $title, $referrer, $utm_source, $utm_medium,
/// $utm_campaign, $utm_term, $utm_content) on every event. SDK authors:
/// do not add these as typed fields here — let the auto-property pipeline
/// supply them so they stay consistent across all event kinds.
class PageViewProperties extends $pb.GeneratedMessage {
  factory PageViewProperties() => create();

  PageViewProperties._();

  factory PageViewProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PageViewProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PageViewProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PageViewProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PageViewProperties copyWith(void Function(PageViewProperties) updates) =>
      super.copyWith((message) => updates(message as PageViewProperties))
          as PageViewProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PageViewProperties create() => PageViewProperties._();
  @$core.override
  PageViewProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PageViewProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PageViewProperties>(create);
  static PageViewProperties? _defaultInstance;
}

/// Native mobile screen navigation. Use page_view for web pages.
///
/// Device, OS, app version, and locale are provided by SDK-injected
/// auto-properties on every event. Only screen-specific fields belong here.
class ScreenViewProperties extends $pb.GeneratedMessage {
  factory ScreenViewProperties({
    $core.String? screenName,
    $core.String? screenClass,
  }) {
    final result = create();
    if (screenName != null) result.screenName = screenName;
    if (screenClass != null) result.screenClass = screenClass;
    return result;
  }

  ScreenViewProperties._();

  factory ScreenViewProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScreenViewProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScreenViewProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'screenName')
    ..aOS(2, _omitFieldNames ? '' : 'screenClass')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScreenViewProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScreenViewProperties copyWith(void Function(ScreenViewProperties) updates) =>
      super.copyWith((message) => updates(message as ScreenViewProperties))
          as ScreenViewProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScreenViewProperties create() => ScreenViewProperties._();
  @$core.override
  ScreenViewProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScreenViewProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScreenViewProperties>(create);
  static ScreenViewProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get screenName => $_getSZ(0);
  @$pb.TagNumber(1)
  set screenName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasScreenName() => $_has(0);
  @$pb.TagNumber(1)
  void clearScreenName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get screenClass => $_getSZ(1);
  @$pb.TagNumber(2)
  set screenClass($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScreenClass() => $_has(1);
  @$pb.TagNumber(2)
  void clearScreenClass() => $_clearField(2);
}

/// A normal user click. Decomposed element fields (class/id/tag/text) match
/// what a DOM-based instrumentation layer can extract directly. Compare
/// rage_click and dead_click which carry an opaque element selector from
/// session-replay tooling.
class ClickProperties extends $pb.GeneratedMessage {
  factory ClickProperties({
    $core.String? class_1,
    $core.String? id,
    $core.String? tag,
    $core.String? text,
    $core.int? x,
    $core.int? y,
  }) {
    final result = create();
    if (class_1 != null) result.class_1 = class_1;
    if (id != null) result.id = id;
    if (tag != null) result.tag = tag;
    if (text != null) result.text = text;
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  ClickProperties._();

  factory ClickProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClickProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClickProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'class')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'tag')
    ..aOS(4, _omitFieldNames ? '' : 'text')
    ..aI(5, _omitFieldNames ? '' : 'x')
    ..aI(6, _omitFieldNames ? '' : 'y')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClickProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClickProperties copyWith(void Function(ClickProperties) updates) =>
      super.copyWith((message) => updates(message as ClickProperties))
          as ClickProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClickProperties create() => ClickProperties._();
  @$core.override
  ClickProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ClickProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClickProperties>(create);
  static ClickProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get class_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set class_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClass_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearClass_1() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get tag => $_getSZ(2);
  @$pb.TagNumber(3)
  set tag($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTag() => $_has(2);
  @$pb.TagNumber(3)
  void clearTag() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get text => $_getSZ(3);
  @$pb.TagNumber(4)
  set text($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get x => $_getIZ(4);
  @$pb.TagNumber(5)
  set x($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasX() => $_has(4);
  @$pb.TagNumber(5)
  void clearX() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get y => $_getIZ(5);
  @$pb.TagNumber(6)
  set y($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasY() => $_has(5);
  @$pb.TagNumber(6)
  void clearY() => $_clearField(6);
}

/// Multiple rapid clicks on the same target, typically detected by
/// session-replay or heuristic tooling. element is an opaque selector
/// produced by that tooling, not a DOM-tree decomposition.
class RageClickProperties extends $pb.GeneratedMessage {
  factory RageClickProperties({
    $core.int? clickCount,
    $core.String? element,
    $core.int? x,
    $core.int? y,
  }) {
    final result = create();
    if (clickCount != null) result.clickCount = clickCount;
    if (element != null) result.element = element;
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  RageClickProperties._();

  factory RageClickProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RageClickProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RageClickProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'clickCount')
    ..aOS(2, _omitFieldNames ? '' : 'element')
    ..aI(3, _omitFieldNames ? '' : 'x')
    ..aI(4, _omitFieldNames ? '' : 'y')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RageClickProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RageClickProperties copyWith(void Function(RageClickProperties) updates) =>
      super.copyWith((message) => updates(message as RageClickProperties))
          as RageClickProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RageClickProperties create() => RageClickProperties._();
  @$core.override
  RageClickProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RageClickProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RageClickProperties>(create);
  static RageClickProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get clickCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set clickCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClickCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearClickCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get element => $_getSZ(1);
  @$pb.TagNumber(2)
  set element($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasElement() => $_has(1);
  @$pb.TagNumber(2)
  void clearElement() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get x => $_getIZ(2);
  @$pb.TagNumber(3)
  set x($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasX() => $_has(2);
  @$pb.TagNumber(3)
  void clearX() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get y => $_getIZ(3);
  @$pb.TagNumber(4)
  set y($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasY() => $_has(3);
  @$pb.TagNumber(4)
  void clearY() => $_clearField(4);
}

/// A click on an element that produced no observable response.
/// element is an opaque selector from session-replay tooling.
class DeadClickProperties extends $pb.GeneratedMessage {
  factory DeadClickProperties({
    $core.String? element,
    $core.String? text,
    $core.int? x,
    $core.int? y,
  }) {
    final result = create();
    if (element != null) result.element = element;
    if (text != null) result.text = text;
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  DeadClickProperties._();

  factory DeadClickProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeadClickProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeadClickProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'element')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..aI(3, _omitFieldNames ? '' : 'x')
    ..aI(4, _omitFieldNames ? '' : 'y')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeadClickProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeadClickProperties copyWith(void Function(DeadClickProperties) updates) =>
      super.copyWith((message) => updates(message as DeadClickProperties))
          as DeadClickProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeadClickProperties create() => DeadClickProperties._();
  @$core.override
  DeadClickProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeadClickProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeadClickProperties>(create);
  static DeadClickProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get element => $_getSZ(0);
  @$pb.TagNumber(1)
  set element($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasElement() => $_has(0);
  @$pb.TagNumber(1)
  void clearElement() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get x => $_getIZ(2);
  @$pb.TagNumber(3)
  set x($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasX() => $_has(2);
  @$pb.TagNumber(3)
  void clearX() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get y => $_getIZ(3);
  @$pb.TagNumber(4)
  set y($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasY() => $_has(3);
  @$pb.TagNumber(4)
  void clearY() => $_clearField(4);
}

class ScrollProperties extends $pb.GeneratedMessage {
  factory ScrollProperties({
    $core.int? percent,
    $core.int? scrollY,
  }) {
    final result = create();
    if (percent != null) result.percent = percent;
    if (scrollY != null) result.scrollY = scrollY;
    return result;
  }

  ScrollProperties._();

  factory ScrollProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScrollProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScrollProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'percent')
    ..aI(2, _omitFieldNames ? '' : 'scrollY')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScrollProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScrollProperties copyWith(void Function(ScrollProperties) updates) =>
      super.copyWith((message) => updates(message as ScrollProperties))
          as ScrollProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScrollProperties create() => ScrollProperties._();
  @$core.override
  ScrollProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScrollProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScrollProperties>(create);
  static ScrollProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get percent => $_getIZ(0);
  @$pb.TagNumber(1)
  set percent($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPercent() => $_has(0);
  @$pb.TagNumber(1)
  void clearPercent() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get scrollY => $_getIZ(1);
  @$pb.TagNumber(2)
  set scrollY($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasScrollY() => $_has(1);
  @$pb.TagNumber(2)
  void clearScrollY() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
