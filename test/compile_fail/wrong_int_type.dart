// expect_error: argument_type_not_assignable
import 'package:pug_sdk/pug_sdk.dart';

void main() {
  // EXPECTED: analyzer error because `quantity` is `int?` but we pass a String.
  // Source of truth: `proto/common/events/v1/commerce_events.proto` —
  //   message AddToCartProperties has `int32 quantity = 4;`
  // The typed generator renders int32 as `int?` on the Dart side.
  Pug.track.addToCart(productId: 'sku-1', quantity: 'two'); // 'two' is not int
}
