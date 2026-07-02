// expect_error: missing_required_argument
import 'package:pug_flutter/pug_flutter.dart';

void main() {
  // EXPECTED: analyzer error because `productId` is required.
  // Source of truth: `proto/common/events/v1/commerce_events.proto` —
  //   message AddToCartProperties has
  //     `string product_id = 1 [(buf.validate.field).required = true];`
  // This fixture intentionally exercises a different event than
  // `missing_required_field.dart` so a regression in the codegen that drops
  // `required` from one event without affecting others is still caught.
  Pug.track.addToCart(); // 'productId' is required — omitting it must fail.
}
