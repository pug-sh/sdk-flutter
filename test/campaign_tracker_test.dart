import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';
import 'package:pug_flutter/src/campaign.dart';
import 'package:pug_flutter/src/campaign_tracker.dart';
import 'package:pug_flutter/src/state_storage.dart';

import 'test_support.dart';

// Campaign capture is not on the public surface and PugClient no longer starts
// it, so these exercise CampaignTracker directly. They are what keeps the
// feature honest until the backend accepts campaign data and the client wires
// it back in.
void main() {
  const keys = PugStorageKeys('project');

  CampaignTracker tracker(MemoryPugStorage storage, PugLinkProvider provider) {
    final tracker = CampaignTracker(
      keys: keys,
      storage: storage,
      logger: const NoopPugLogger(),
      provider: provider,
    );
    addTearDown(tracker.dispose);
    return tracker;
  }

  test('captures campaign properties from the initial app link', () async {
    final storage = MemoryPugStorage();
    final subject = tracker(
      storage,
      FakeLinkProvider(
        initial: Uri.parse(
          'https://example.com/welcome?utm_source=google&utm_medium=cpc'
          '&utm_campaign=spring&gclid=click-1',
        ),
      ),
    );

    await subject.start();

    expect(subject.properties(), {
      r'$utmSource': 'google',
      r'$utmMedium': 'cpc',
      r'$utmCampaign': 'spring',
      r'$gclid': 'click-1',
    });
  });

  test('later app links replace the stored campaign', () async {
    final storage = MemoryPugStorage();
    final provider = FakeLinkProvider();
    final subject = tracker(storage, provider);
    await subject.start();

    provider.add(
      Uri.parse('pug://open?utm_source=newsletter&utm_content=hero'),
    );
    await Future<void>.delayed(Duration.zero);

    expect(subject.properties(), {
      r'$utmSource': 'newsletter',
      r'$utmContent': 'hero',
    });
  });

  test(
    'links without campaign parameters leave the stored campaign alone',
    () async {
      final storage = MemoryPugStorage();
      final provider = FakeLinkProvider(
        initial: Uri.parse('pug://open?utm_source=google'),
      );
      final subject = tracker(storage, provider);
      await subject.start();

      provider.add(Uri.parse('pug://open?ref=friend'));
      await Future<void>.delayed(Duration.zero);

      expect(subject.properties(), {r'$utmSource': 'google'});
    },
  );

  test('clear drops the persisted campaign', () async {
    final storage = MemoryPugStorage();
    final subject = tracker(
      storage,
      FakeLinkProvider(initial: Uri.parse('pug://open?utm_source=google')),
    );
    await subject.start();
    expect(storage.getString(keys.campaign), isNotNull);

    subject.clear();

    expect(storage.getString(keys.campaign), isNull);
    expect(subject.properties(), isEmpty);
  });

  test(
    'PugClient does not attach campaign properties while capture is off',
    () {
      final storage = MemoryPugStorage();
      storage.setString(keys.campaign, '{"\$utmSource":"google"}');
      final client = testClient(storage: storage);

      client.track('signup');

      final autoProperties = client.queue.peekUnlocked().single.autoProperties;
      expect(autoProperties.containsKey(r'$utmSource'), isFalse);
    },
  );
}
