import 'dart:typed_data';

import 'package:connectrpc/connect.dart' as connect;
import 'package:protobuf/protobuf.dart';

final ArgumentError _invalidMessageType = ArgumentError(
  'Invalid message type, expected a GeneratedMessage.',
);

class ConnectProtoCodec implements connect.Codec {
  const ConnectProtoCodec();

  @override
  String get name => 'proto';

  @override
  Uint8List encode(Object message) {
    if (message is! GeneratedMessage) {
      throw _invalidMessageType;
    }
    return Uint8List.fromList(message.writeToBuffer());
  }

  @override
  void decode(Uint8List data, Object message) {
    if (message is! GeneratedMessage) {
      throw _invalidMessageType;
    }
    message.mergeFromBuffer(data);
  }
}
