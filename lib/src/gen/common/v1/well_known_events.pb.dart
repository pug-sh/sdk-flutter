// This is a generated file - do not edit.
//
// Generated from common/v1/well_known_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// kind: "page_view"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "click"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "rage_click"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "dead_click"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "scroll"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "search"
class SearchProperties extends $pb.GeneratedMessage {
  factory SearchProperties({
    $core.String? query,
  }) {
    final result = create();
    if (query != null) result.query = query;
    return result;
  }

  SearchProperties._();

  factory SearchProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchProperties copyWith(void Function(SearchProperties) updates) =>
      super.copyWith((message) => updates(message as SearchProperties))
          as SearchProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchProperties create() => SearchProperties._();
  @$core.override
  SearchProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchProperties>(create);
  static SearchProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);
}

/// kind: "add_to_cart"
class AddToCartProperties extends $pb.GeneratedMessage {
  factory AddToCartProperties({
    $core.String? productId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  AddToCartProperties._();

  factory AddToCartProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddToCartProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddToCartProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddToCartProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddToCartProperties copyWith(void Function(AddToCartProperties) updates) =>
      super.copyWith((message) => updates(message as AddToCartProperties))
          as AddToCartProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddToCartProperties create() => AddToCartProperties._();
  @$core.override
  AddToCartProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AddToCartProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddToCartProperties>(create);
  static AddToCartProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);
}

/// kind: "checkout_started"
class CheckoutStartedProperties extends $pb.GeneratedMessage {
  factory CheckoutStartedProperties({
    $core.String? productId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  CheckoutStartedProperties._();

  factory CheckoutStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckoutStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckoutStartedProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutStartedProperties copyWith(
          void Function(CheckoutStartedProperties) updates) =>
      super.copyWith((message) => updates(message as CheckoutStartedProperties))
          as CheckoutStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckoutStartedProperties create() => CheckoutStartedProperties._();
  @$core.override
  CheckoutStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CheckoutStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckoutStartedProperties>(create);
  static CheckoutStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);
}

/// kind: "checkout_completed"
class CheckoutCompletedProperties extends $pb.GeneratedMessage {
  factory CheckoutCompletedProperties({
    $core.String? productId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  CheckoutCompletedProperties._();

  factory CheckoutCompletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckoutCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckoutCompletedProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutCompletedProperties copyWith(
          void Function(CheckoutCompletedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as CheckoutCompletedProperties))
          as CheckoutCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckoutCompletedProperties create() =>
      CheckoutCompletedProperties._();
  @$core.override
  CheckoutCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CheckoutCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckoutCompletedProperties>(create);
  static CheckoutCompletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);
}

/// kind: "purchase"
class PurchaseProperties extends $pb.GeneratedMessage {
  factory PurchaseProperties({
    $core.String? productId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  PurchaseProperties._();

  factory PurchaseProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseProperties copyWith(void Function(PurchaseProperties) updates) =>
      super.copyWith((message) => updates(message as PurchaseProperties))
          as PurchaseProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseProperties create() => PurchaseProperties._();
  @$core.override
  PurchaseProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PurchaseProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseProperties>(create);
  static PurchaseProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);
}

/// kind: "form_start"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "form_submit"
class FormSubmitProperties extends $pb.GeneratedMessage {
  factory FormSubmitProperties({
    $core.String? action,
    $core.String? formId,
    $core.String? formName,
  }) {
    final result = create();
    if (action != null) result.action = action;
    if (formId != null) result.formId = formId;
    if (formName != null) result.formName = formName;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'action')
    ..aOS(2, _omitFieldNames ? '' : 'formId')
    ..aOS(3, _omitFieldNames ? '' : 'formName')
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
  $core.String get action => $_getSZ(0);
  @$pb.TagNumber(1)
  set action($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get formId => $_getSZ(1);
  @$pb.TagNumber(2)
  set formId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFormId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get formName => $_getSZ(2);
  @$pb.TagNumber(3)
  set formName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFormName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormName() => $_clearField(3);
}

/// kind: "signup"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "login"
class LoginProperties extends $pb.GeneratedMessage {
  factory LoginProperties() => create();

  LoginProperties._();

  factory LoginProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginProperties copyWith(void Function(LoginProperties) updates) =>
      super.copyWith((message) => updates(message as LoginProperties))
          as LoginProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginProperties create() => LoginProperties._();
  @$core.override
  LoginProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LoginProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginProperties>(create);
  static LoginProperties? _defaultInstance;
}

/// kind: "logout"
class LogoutProperties extends $pb.GeneratedMessage {
  factory LogoutProperties() => create();

  LogoutProperties._();

  factory LogoutProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutProperties copyWith(void Function(LogoutProperties) updates) =>
      super.copyWith((message) => updates(message as LogoutProperties))
          as LogoutProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutProperties create() => LogoutProperties._();
  @$core.override
  LogoutProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogoutProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutProperties>(create);
  static LogoutProperties? _defaultInstance;
}

/// kind: "app_open"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "app_close"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "notification_received"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "notification_clicked"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "notification_dismissed"
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
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

/// kind: "video_play"
class VideoPlayProperties extends $pb.GeneratedMessage {
  factory VideoPlayProperties({
    $core.String? videoId,
    $core.int? positionS,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    if (positionS != null) result.positionS = positionS;
    return result;
  }

  VideoPlayProperties._();

  factory VideoPlayProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoPlayProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoPlayProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aI(2, _omitFieldNames ? '' : 'positionS')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPlayProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPlayProperties copyWith(void Function(VideoPlayProperties) updates) =>
      super.copyWith((message) => updates(message as VideoPlayProperties))
          as VideoPlayProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoPlayProperties create() => VideoPlayProperties._();
  @$core.override
  VideoPlayProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoPlayProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoPlayProperties>(create);
  static VideoPlayProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get positionS => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionS($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionS() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionS() => $_clearField(2);
}

/// kind: "video_pause"
class VideoPauseProperties extends $pb.GeneratedMessage {
  factory VideoPauseProperties({
    $core.String? videoId,
    $core.int? positionS,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    if (positionS != null) result.positionS = positionS;
    return result;
  }

  VideoPauseProperties._();

  factory VideoPauseProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoPauseProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoPauseProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aI(2, _omitFieldNames ? '' : 'positionS')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPauseProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPauseProperties copyWith(void Function(VideoPauseProperties) updates) =>
      super.copyWith((message) => updates(message as VideoPauseProperties))
          as VideoPauseProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoPauseProperties create() => VideoPauseProperties._();
  @$core.override
  VideoPauseProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoPauseProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoPauseProperties>(create);
  static VideoPauseProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get positionS => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionS($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionS() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionS() => $_clearField(2);
}

/// kind: "error_occurred"
class ErrorOccurredProperties extends $pb.GeneratedMessage {
  factory ErrorOccurredProperties({
    $core.String? errorCode,
  }) {
    final result = create();
    if (errorCode != null) result.errorCode = errorCode;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'errorCode')
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
}

/// kind: "share"
class ShareProperties extends $pb.GeneratedMessage {
  factory ShareProperties() => create();

  ShareProperties._();

  factory ShareProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ShareProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ShareProperties',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'common.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShareProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShareProperties copyWith(void Function(ShareProperties) updates) =>
      super.copyWith((message) => updates(message as ShareProperties))
          as ShareProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShareProperties create() => ShareProperties._();
  @$core.override
  ShareProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ShareProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ShareProperties>(create);
  static ShareProperties? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
