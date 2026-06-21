// expect_error: argument_type_not_assignable
import 'package:pug_sdk/pug_sdk.dart';

void main() {
  // EXPECTED: analyzer error because `amount` is `double?` but we pass a String.
  // Source of truth: `proto/common/events/v1/commerce_events.proto` —
  //   message PurchaseProperties has `double amount = 2;`
  // The typed generator renders this as `double? amount` in
  // `Pug.track.purchase(...)` (optional because the proto does not mark it
  // required). Passing a String literal is a type mismatch.
  Pug.track.purchase(amount: '99.50'); // amount is double?, not String
}
