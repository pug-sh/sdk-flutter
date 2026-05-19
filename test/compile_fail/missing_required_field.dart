// expect_error: missing_required_argument
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

void main() {
  // EXPECTED: analyzer error because `query` is required.
  // Source of truth: `proto/common/events/v1/discovery_events.proto` —
  //   message SearchProperties has
  //     `string query = 1 [(buf.validate.field).required = true];`
  // The typed generator (tool/generate_track_namespace.dart) renders this
  // as `required String query` in `Pug.track.search(...)`.
  Pug.track.search(); // 'query' is required — omitting it must fail to compile.
}
