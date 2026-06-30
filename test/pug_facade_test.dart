import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('default endpoint points at production, not localhost', () {
    const options = PugOptions(apiKey: 'key');
    expect(options.endpoint, 'https://polru.pug.sh');
  });

  test(
    'init validates required values and repeated init warns and is ignored',
    () async {
      await expectLater(
        Pug.init('', const PugOptions(apiKey: 'key', autoTrack: false)),
        throwsA(isA<ArgumentError>()),
      );

      final logger = CapturingLogger();
      final transport = FakeTransport();
      await Pug.init(
        'project',
        PugOptions(
          apiKey: 'key',
          logger: logger,
          transport: transport,
          storage: MemoryPugStorage(),
          autoTrack: false,
        ),
      );

      await expectLater(
        Pug.init(
          'project',
          PugOptions(apiKey: 'key', logger: logger, autoTrack: false),
        ),
        completes,
      );
      expect(
        logger.warnings,
        contains('Pug.init() called after initialization; ignoring.'),
      );

      Pug.destroy();
    },
  );

  test('init uses shared preferences storage by default', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    await Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: FakeTransport(),
        autoTrack: false,
        batch: const BatchConfig(maxWaitMs: 60000),
      ),
    );
    Pug.track(PugEventNames.signup);

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('__pug_project_queue__'), contains('signup'));
    Pug.destroy();
  });

  test('init and identify remain safe when logger throws', () async {
    await expectLater(
      Pug.init(
        '',
        const PugOptions(
          apiKey: 'key',
          logger: ThrowingLogger(),
          autoTrack: false,
        ),
      ),
      throwsA(isA<ArgumentError>()),
    );

    final client = testClient(
      logger: const ThrowingLogger(),
      autoCaptureCampaigns: false,
    );
    await expectLater(client.identify(''), throwsA(isA<ArgumentError>()));
    Pug.destroy();
    await expectLater(Pug.identify('user-before-init'), completes);
    expect(
      () => client.track('purchase', props: {'bad': double.nan}),
      returnsNormally,
    );
  });
}
