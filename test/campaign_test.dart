import 'package:flutter_test/flutter_test.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('campaign properties are captured from initial app link', () async {
    final client = testClient(
      linkProvider: FakeLinkProvider(
        initial: Uri.parse(
          'https://example.com/welcome?utm_source=google&utm_medium=cpc'
          '&utm_campaign=spring&gclid=click-1',
        ),
      ),
      autoCaptureCampaigns: true,
    );
    await Future<void>.delayed(Duration.zero);

    client.track('signup');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$utmSource']?.value, 'google');
    expect(autoProperties[r'$utmMedium']?.value, 'cpc');
    expect(autoProperties[r'$utmCampaign']?.value, 'spring');
    expect(autoProperties[r'$gclid']?.value, 'click-1');
  });

  test('campaign properties update from later app links', () async {
    final linkProvider = FakeLinkProvider();
    final client = testClient(
      linkProvider: linkProvider,
      autoCaptureCampaigns: true,
    );
    await Future<void>.delayed(Duration.zero);

    linkProvider.add(
      Uri.parse('pug://open?utm_source=newsletter&utm_content=hero'),
    );
    await Future<void>.delayed(Duration.zero);
    client.track('open');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$utmSource']?.value, 'newsletter');
    expect(autoProperties[r'$utmContent']?.value, 'hero');
  });
}
