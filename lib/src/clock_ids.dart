import 'dart:math';
import 'dart:typed_data';

abstract interface class PugClock {
  int nowMillis();
}

class SystemPugClock implements PugClock {
  @override
  int nowMillis() => DateTime.now().millisecondsSinceEpoch;
}

abstract interface class PugIdGenerator {
  String nextId();
}

class UuidV7Generator implements PugIdGenerator {
  UuidV7Generator({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  @override
  String nextId() {
    final bytes = Uint8List(16);
    final now = DateTime.now().millisecondsSinceEpoch;
    for (var i = 0; i < 6; i += 1) {
      bytes[i] = (now >> (8 * (5 - i))) & 0xff;
    }
    for (var i = 6; i < 16; i += 1) {
      bytes[i] = _random.nextInt(256);
    }
    bytes[6] = (bytes[6] & 0x0f) | 0x70;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-'
        '${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
