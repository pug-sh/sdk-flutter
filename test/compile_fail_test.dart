import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('compile-fail fixtures', () {
    final fixtures = Directory('test/compile_fail')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    for (final file in fixtures) {
      test(file.path, () async {
        final firstLine = (await file.readAsLines()).first;
        final expected = firstLine.replaceFirst('// expect_error:', '').trim();

        final result = await Process.run(
          'dart',
          ['analyze', '--no-fatal-warnings', file.path],
          runInShell: true,
        );

        // dart analyze exits 0 on no errors, non-zero when errors present.
        expect(result.exitCode, isNonZero,
            reason:
                'Expected ${file.path} to fail analysis but it succeeded.\nstdout: ${result.stdout}\nstderr: ${result.stderr}');

        // Soft-assert the expected error code appears in output.
        // If the analyzer's output format changes, downgrade this to a print.
        expect(
          result.stdout.toString() + result.stderr.toString(),
          contains(expected),
          reason:
              'Analyzer output did not contain expected error code "$expected".\nFull output:\nstdout: ${result.stdout}\nstderr: ${result.stderr}',
        );
      });
    }
  });
}
