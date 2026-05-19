// expect_error: argument_type_not_assignable
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

void main() {
  // EXPECTED: analyzer error because 'amount' is double? but we pass a String.
  // purchase() has `double? amount` in track_namespace.dart — passing a String
  // literal is a type mismatch the analyzer must catch.
  Pug.track.purchase(amount: '99.50'); // amount is double?, not String
}
