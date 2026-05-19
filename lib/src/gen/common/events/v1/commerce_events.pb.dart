// This is a generated file - do not edit.
//
// Generated from common/events/v1/commerce_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ProductViewedProperties extends $pb.GeneratedMessage {
  factory ProductViewedProperties({
    $core.String? productId,
    $core.String? productName,
    $core.String? category,
    $core.String? brand,
    $core.String? sku,
    $core.double? price,
    $core.String? currency,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (productName != null) result.productName = productName;
    if (category != null) result.category = category;
    if (brand != null) result.brand = brand;
    if (sku != null) result.sku = sku;
    if (price != null) result.price = price;
    if (currency != null) result.currency = currency;
    return result;
  }

  ProductViewedProperties._();

  factory ProductViewedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProductViewedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProductViewedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'productName')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'brand')
    ..aOS(5, _omitFieldNames ? '' : 'sku')
    ..aD(6, _omitFieldNames ? '' : 'price')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProductViewedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProductViewedProperties copyWith(
          void Function(ProductViewedProperties) updates) =>
      super.copyWith((message) => updates(message as ProductViewedProperties))
          as ProductViewedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProductViewedProperties create() => ProductViewedProperties._();
  @$core.override
  ProductViewedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProductViewedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProductViewedProperties>(create);
  static ProductViewedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productName => $_getSZ(1);
  @$pb.TagNumber(2)
  set productName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get brand => $_getSZ(3);
  @$pb.TagNumber(4)
  set brand($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBrand() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrand() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sku => $_getSZ(4);
  @$pb.TagNumber(5)
  set sku($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSku() => $_has(4);
  @$pb.TagNumber(5)
  void clearSku() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get price => $_getN(5);
  @$pb.TagNumber(6)
  set price($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearPrice() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);
}

/// A list/category/search-results impression — fired when the user views a
/// collection of products rather than a single product detail page.
class ProductListViewedProperties extends $pb.GeneratedMessage {
  factory ProductListViewedProperties({
    $core.String? listId,
    $core.String? listName,
    $core.String? category,
    $core.int? itemCount,
  }) {
    final result = create();
    if (listId != null) result.listId = listId;
    if (listName != null) result.listName = listName;
    if (category != null) result.category = category;
    if (itemCount != null) result.itemCount = itemCount;
    return result;
  }

  ProductListViewedProperties._();

  factory ProductListViewedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProductListViewedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProductListViewedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'listId')
    ..aOS(2, _omitFieldNames ? '' : 'listName')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aI(4, _omitFieldNames ? '' : 'itemCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProductListViewedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProductListViewedProperties copyWith(
          void Function(ProductListViewedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ProductListViewedProperties))
          as ProductListViewedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProductListViewedProperties create() =>
      ProductListViewedProperties._();
  @$core.override
  ProductListViewedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProductListViewedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProductListViewedProperties>(create);
  static ProductListViewedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get listId => $_getSZ(0);
  @$pb.TagNumber(1)
  set listId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasListId() => $_has(0);
  @$pb.TagNumber(1)
  void clearListId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get listName => $_getSZ(1);
  @$pb.TagNumber(2)
  set listName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasListName() => $_has(1);
  @$pb.TagNumber(2)
  void clearListName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasItemCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemCount() => $_clearField(4);
}

class AddToCartProperties extends $pb.GeneratedMessage {
  factory AddToCartProperties({
    $core.String? productId,
    $core.double? price,
    $core.String? currency,
    $core.String? cartId,
    $core.int? quantity,
    $core.String? category,
    $core.String? brand,
    $core.String? sku,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (price != null) result.price = price;
    if (currency != null) result.currency = currency;
    if (cartId != null) result.cartId = cartId;
    if (quantity != null) result.quantity = quantity;
    if (category != null) result.category = category;
    if (brand != null) result.brand = brand;
    if (sku != null) result.sku = sku;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'price')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'cartId')
    ..aI(5, _omitFieldNames ? '' : 'quantity')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..aOS(7, _omitFieldNames ? '' : 'brand')
    ..aOS(8, _omitFieldNames ? '' : 'sku')
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
  $core.double get price => $_getN(1);
  @$pb.TagNumber(2)
  set price($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrice() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get cartId => $_getSZ(3);
  @$pb.TagNumber(4)
  set cartId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCartId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCartId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get quantity => $_getIZ(4);
  @$pb.TagNumber(5)
  set quantity($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get brand => $_getSZ(6);
  @$pb.TagNumber(7)
  set brand($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBrand() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrand() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sku => $_getSZ(7);
  @$pb.TagNumber(8)
  set sku($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSku() => $_has(7);
  @$pb.TagNumber(8)
  void clearSku() => $_clearField(8);
}

class RemoveFromCartProperties extends $pb.GeneratedMessage {
  factory RemoveFromCartProperties({
    $core.String? productId,
    $core.double? price,
    $core.String? currency,
    $core.String? cartId,
    $core.int? quantity,
    $core.String? category,
    $core.String? brand,
    $core.String? sku,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (price != null) result.price = price;
    if (currency != null) result.currency = currency;
    if (cartId != null) result.cartId = cartId;
    if (quantity != null) result.quantity = quantity;
    if (category != null) result.category = category;
    if (brand != null) result.brand = brand;
    if (sku != null) result.sku = sku;
    return result;
  }

  RemoveFromCartProperties._();

  factory RemoveFromCartProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFromCartProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFromCartProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'price')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'cartId')
    ..aI(5, _omitFieldNames ? '' : 'quantity')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..aOS(7, _omitFieldNames ? '' : 'brand')
    ..aOS(8, _omitFieldNames ? '' : 'sku')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFromCartProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFromCartProperties copyWith(
          void Function(RemoveFromCartProperties) updates) =>
      super.copyWith((message) => updates(message as RemoveFromCartProperties))
          as RemoveFromCartProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFromCartProperties create() => RemoveFromCartProperties._();
  @$core.override
  RemoveFromCartProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RemoveFromCartProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFromCartProperties>(create);
  static RemoveFromCartProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get price => $_getN(1);
  @$pb.TagNumber(2)
  set price($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrice() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get cartId => $_getSZ(3);
  @$pb.TagNumber(4)
  set cartId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCartId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCartId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get quantity => $_getIZ(4);
  @$pb.TagNumber(5)
  set quantity($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get brand => $_getSZ(6);
  @$pb.TagNumber(7)
  set brand($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBrand() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrand() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sku => $_getSZ(7);
  @$pb.TagNumber(8)
  set sku($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSku() => $_has(7);
  @$pb.TagNumber(8)
  void clearSku() => $_clearField(8);
}

class CartViewedProperties extends $pb.GeneratedMessage {
  factory CartViewedProperties({
    $core.String? cartId,
    $core.int? itemCount,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (cartId != null) result.cartId = cartId;
    if (itemCount != null) result.itemCount = itemCount;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  CartViewedProperties._();

  factory CartViewedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CartViewedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CartViewedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cartId')
    ..aI(2, _omitFieldNames ? '' : 'itemCount')
    ..aD(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CartViewedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CartViewedProperties copyWith(void Function(CartViewedProperties) updates) =>
      super.copyWith((message) => updates(message as CartViewedProperties))
          as CartViewedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CartViewedProperties create() => CartViewedProperties._();
  @$core.override
  CartViewedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CartViewedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CartViewedProperties>(create);
  static CartViewedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cartId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cartId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCartId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCartId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get itemCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set itemCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemCount() => $_clearField(2);

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

class WishlistAddedProperties extends $pb.GeneratedMessage {
  factory WishlistAddedProperties({
    $core.String? productId,
    $core.String? wishlistId,
    $core.double? price,
    $core.String? currency,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (wishlistId != null) result.wishlistId = wishlistId;
    if (price != null) result.price = price;
    if (currency != null) result.currency = currency;
    return result;
  }

  WishlistAddedProperties._();

  factory WishlistAddedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WishlistAddedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WishlistAddedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'wishlistId')
    ..aD(3, _omitFieldNames ? '' : 'price')
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WishlistAddedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WishlistAddedProperties copyWith(
          void Function(WishlistAddedProperties) updates) =>
      super.copyWith((message) => updates(message as WishlistAddedProperties))
          as WishlistAddedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WishlistAddedProperties create() => WishlistAddedProperties._();
  @$core.override
  WishlistAddedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WishlistAddedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WishlistAddedProperties>(create);
  static WishlistAddedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get wishlistId => $_getSZ(1);
  @$pb.TagNumber(2)
  set wishlistId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWishlistId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWishlistId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);
}

class WishlistRemovedProperties extends $pb.GeneratedMessage {
  factory WishlistRemovedProperties({
    $core.String? productId,
    $core.String? wishlistId,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (wishlistId != null) result.wishlistId = wishlistId;
    return result;
  }

  WishlistRemovedProperties._();

  factory WishlistRemovedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WishlistRemovedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WishlistRemovedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'wishlistId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WishlistRemovedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WishlistRemovedProperties copyWith(
          void Function(WishlistRemovedProperties) updates) =>
      super.copyWith((message) => updates(message as WishlistRemovedProperties))
          as WishlistRemovedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WishlistRemovedProperties create() => WishlistRemovedProperties._();
  @$core.override
  WishlistRemovedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WishlistRemovedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WishlistRemovedProperties>(create);
  static WishlistRemovedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get wishlistId => $_getSZ(1);
  @$pb.TagNumber(2)
  set wishlistId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWishlistId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWishlistId() => $_clearField(2);
}

class CouponAppliedProperties extends $pb.GeneratedMessage {
  factory CouponAppliedProperties({
    $core.String? couponId,
    $core.String? couponCode,
    $core.String? cartId,
    $core.double? discountAmount,
    $core.String? currency,
  }) {
    final result = create();
    if (couponId != null) result.couponId = couponId;
    if (couponCode != null) result.couponCode = couponCode;
    if (cartId != null) result.cartId = cartId;
    if (discountAmount != null) result.discountAmount = discountAmount;
    if (currency != null) result.currency = currency;
    return result;
  }

  CouponAppliedProperties._();

  factory CouponAppliedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CouponAppliedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CouponAppliedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'couponId')
    ..aOS(2, _omitFieldNames ? '' : 'couponCode')
    ..aOS(3, _omitFieldNames ? '' : 'cartId')
    ..aD(4, _omitFieldNames ? '' : 'discountAmount')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CouponAppliedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CouponAppliedProperties copyWith(
          void Function(CouponAppliedProperties) updates) =>
      super.copyWith((message) => updates(message as CouponAppliedProperties))
          as CouponAppliedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CouponAppliedProperties create() => CouponAppliedProperties._();
  @$core.override
  CouponAppliedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CouponAppliedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CouponAppliedProperties>(create);
  static CouponAppliedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get couponId => $_getSZ(0);
  @$pb.TagNumber(1)
  set couponId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCouponId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCouponId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get couponCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set couponCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCouponCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCouponCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cartId => $_getSZ(2);
  @$pb.TagNumber(3)
  set cartId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCartId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCartId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get discountAmount => $_getN(3);
  @$pb.TagNumber(4)
  set discountAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDiscountAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearDiscountAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);
}

class CouponRemovedProperties extends $pb.GeneratedMessage {
  factory CouponRemovedProperties({
    $core.String? couponId,
    $core.String? couponCode,
    $core.String? cartId,
    $core.String? reason,
  }) {
    final result = create();
    if (couponId != null) result.couponId = couponId;
    if (couponCode != null) result.couponCode = couponCode;
    if (cartId != null) result.cartId = cartId;
    if (reason != null) result.reason = reason;
    return result;
  }

  CouponRemovedProperties._();

  factory CouponRemovedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CouponRemovedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CouponRemovedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'couponId')
    ..aOS(2, _omitFieldNames ? '' : 'couponCode')
    ..aOS(3, _omitFieldNames ? '' : 'cartId')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CouponRemovedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CouponRemovedProperties copyWith(
          void Function(CouponRemovedProperties) updates) =>
      super.copyWith((message) => updates(message as CouponRemovedProperties))
          as CouponRemovedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CouponRemovedProperties create() => CouponRemovedProperties._();
  @$core.override
  CouponRemovedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CouponRemovedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CouponRemovedProperties>(create);
  static CouponRemovedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get couponId => $_getSZ(0);
  @$pb.TagNumber(1)
  set couponId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCouponId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCouponId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get couponCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set couponCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCouponCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCouponCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cartId => $_getSZ(2);
  @$pb.TagNumber(3)
  set cartId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCartId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCartId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);
}

class CheckoutStartedProperties extends $pb.GeneratedMessage {
  factory CheckoutStartedProperties({
    $core.String? productId,
    $core.double? amount,
    $core.String? currency,
    $core.String? cartId,
    $core.String? checkoutId,
    $core.int? itemCount,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (cartId != null) result.cartId = cartId;
    if (checkoutId != null) result.checkoutId = checkoutId;
    if (itemCount != null) result.itemCount = itemCount;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'cartId')
    ..aOS(5, _omitFieldNames ? '' : 'checkoutId')
    ..aI(6, _omitFieldNames ? '' : 'itemCount')
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

  @$pb.TagNumber(4)
  $core.String get cartId => $_getSZ(3);
  @$pb.TagNumber(4)
  set cartId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCartId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCartId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get checkoutId => $_getSZ(4);
  @$pb.TagNumber(5)
  set checkoutId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCheckoutId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCheckoutId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get itemCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set itemCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasItemCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearItemCount() => $_clearField(6);
}

class CheckoutStepCompletedProperties extends $pb.GeneratedMessage {
  factory CheckoutStepCompletedProperties({
    $core.String? checkoutId,
    $core.String? step,
    $core.int? stepIndex,
  }) {
    final result = create();
    if (checkoutId != null) result.checkoutId = checkoutId;
    if (step != null) result.step = step;
    if (stepIndex != null) result.stepIndex = stepIndex;
    return result;
  }

  CheckoutStepCompletedProperties._();

  factory CheckoutStepCompletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckoutStepCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckoutStepCompletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'checkoutId')
    ..aOS(2, _omitFieldNames ? '' : 'step')
    ..aI(3, _omitFieldNames ? '' : 'stepIndex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutStepCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckoutStepCompletedProperties copyWith(
          void Function(CheckoutStepCompletedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as CheckoutStepCompletedProperties))
          as CheckoutStepCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckoutStepCompletedProperties create() =>
      CheckoutStepCompletedProperties._();
  @$core.override
  CheckoutStepCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CheckoutStepCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckoutStepCompletedProperties>(
          create);
  static CheckoutStepCompletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get checkoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set checkoutId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCheckoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCheckoutId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get step => $_getSZ(1);
  @$pb.TagNumber(2)
  set step($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStep() => $_has(1);
  @$pb.TagNumber(2)
  void clearStep() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get stepIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set stepIndex($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStepIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepIndex() => $_clearField(3);
}

/// Equivalent to Segment's "Order Completed" event. Fires once per successful
/// order, after payment is confirmed.
class PurchaseProperties extends $pb.GeneratedMessage {
  factory PurchaseProperties({
    $core.String? productId,
    $core.double? amount,
    $core.String? currency,
    $core.String? orderId,
    $core.int? quantity,
    $core.String? category,
    $core.String? brand,
    $core.String? sku,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (orderId != null) result.orderId = orderId;
    if (quantity != null) result.quantity = quantity;
    if (category != null) result.category = category;
    if (brand != null) result.brand = brand;
    if (sku != null) result.sku = sku;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'orderId')
    ..aI(5, _omitFieldNames ? '' : 'quantity')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..aOS(7, _omitFieldNames ? '' : 'brand')
    ..aOS(8, _omitFieldNames ? '' : 'sku')
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

  @$pb.TagNumber(4)
  $core.String get orderId => $_getSZ(3);
  @$pb.TagNumber(4)
  set orderId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get quantity => $_getIZ(4);
  @$pb.TagNumber(5)
  set quantity($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get brand => $_getSZ(6);
  @$pb.TagNumber(7)
  set brand($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBrand() => $_has(6);
  @$pb.TagNumber(7)
  void clearBrand() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sku => $_getSZ(7);
  @$pb.TagNumber(8)
  set sku($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSku() => $_has(7);
  @$pb.TagNumber(8)
  void clearSku() => $_clearField(8);
}

class OrderRefundedProperties extends $pb.GeneratedMessage {
  factory OrderRefundedProperties({
    $core.String? orderId,
    $core.double? amount,
    $core.String? currency,
    $core.String? reason,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (reason != null) result.reason = reason;
    return result;
  }

  OrderRefundedProperties._();

  factory OrderRefundedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderRefundedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderRefundedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderRefundedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderRefundedProperties copyWith(
          void Function(OrderRefundedProperties) updates) =>
      super.copyWith((message) => updates(message as OrderRefundedProperties))
          as OrderRefundedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderRefundedProperties create() => OrderRefundedProperties._();
  @$core.override
  OrderRefundedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OrderRefundedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderRefundedProperties>(create);
  static OrderRefundedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

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

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
