// expect_error: missing_required_argument
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

void main() {
  // EXPECTED: analyzer error because 'query' is required by the search event.
  // Chosen event: search(), which has `required String query` in track_namespace.dart.
  // (purchase() was not used here because it has NO required fields in the proto —
  // all its fields including productId are optional, so purchase() with no args
  // compiles fine. search() is the simplest event with a required field.)
  Pug.track.search(); // 'query' is required — omitting it must fail to compile.
}
