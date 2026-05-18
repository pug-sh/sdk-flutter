import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart'
    as structpb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

import 'events.dart';
import 'gen/common/v1/property_value.pb.dart' as commonpb;
import 'gen/sdk/devices/v1/devices.pb.dart' as devicespb;
import 'gen/sdk/events/v1/events.pb.dart' as eventspb;
import 'gen/sdk/profiles/v1/profiles.pb.dart' as profilespb;
import 'push_models.dart';

class PugProtoCodec {
  const PugProtoCodec();

  List<int> encodeBatchCreateRequest(List<Event> events) {
    return eventspb.BatchCreateRequest(
      events: events.map(_toProtoEvent),
    ).writeToBuffer();
  }

  List<int> encodeIdentifyRequest(IdentifyRequest request) {
    final proto = profilespb.IdentifyRequest(
      externalId: request.externalId,
      traits: _toStruct(_propertyMapToPlain(request.traits)),
    );
    if (request.anonymousId != null) {
      proto.anonymousId = request.anonymousId!;
    }
    if (request.deviceId != null) {
      proto.deviceId = request.deviceId!;
    }
    return proto.writeToBuffer();
  }

  List<int> encodeSubscribeRequest(PushSubscription subscription) {
    return devicespb.SubscribeRequest(
      deviceId: subscription.deviceId,
      platform: subscription.platform,
      profileExternalId: subscription.profileExternalId,
      profileId: subscription.profileId,
      token: subscription.token,
      properties: _toStruct(subscription.properties),
    ).writeToBuffer();
  }

  eventspb.Event _toProtoEvent(Event event) {
    return eventspb.Event(
      eventId: event.eventId,
      autoProperties: event.autoProperties.entries.map(
        (entry) => MapEntry(entry.key, _toProtoPropertyValue(entry.value)),
      ),
      customProperties: event.customProperties.entries.map(
        (entry) => MapEntry(entry.key, _toProtoPropertyValue(entry.value)),
      ),
      distinctId: event.distinctId,
      kind: event.kind,
      occurTime: _toTimestamp(event.occurTime),
      sessionId: event.sessionId,
    );
  }

  commonpb.PropertyValue _toProtoPropertyValue(PropertyValue property) {
    return switch (property.kind) {
      'stringValue' => commonpb.PropertyValue(
        stringValue: property.value as String,
      ),
      'intValue' => commonpb.PropertyValue(
        intValue: Int64(property.value as int),
      ),
      'doubleValue' => commonpb.PropertyValue(
        doubleValue: property.value as double,
      ),
      'boolValue' => commonpb.PropertyValue(boolValue: property.value as bool),
      'timestampValue' => commonpb.PropertyValue(
        timestampValue: _toTimestamp(property.value as int),
      ),
      _ => commonpb.PropertyValue(stringValue: property.value.toString()),
    };
  }

  Timestamp _toTimestamp(int epochMillis) {
    return Timestamp(
      seconds: Int64(epochMillis ~/ 1000),
      nanos: (epochMillis % 1000) * 1000000,
    );
  }

  Map<String, Object?> _propertyMapToPlain(Map<String, PropertyValue> values) {
    return values.map((key, value) {
      final plain = switch (value.kind) {
        'timestampValue' =>
          DateTime.fromMillisecondsSinceEpoch(
            value.value as int,
            isUtc: true,
          ).toIso8601String(),
        _ => value.value,
      };
      return MapEntry(key, plain);
    });
  }

  structpb.Struct _toStruct(Map<String, Object?> values) {
    return structpb.Struct(
      fields: values.entries.map(
        (entry) => MapEntry(entry.key, _toValue(entry.value)),
      ),
    );
  }

  structpb.Value _toValue(Object? value) {
    if (value == null) {
      return structpb.Value(nullValue: structpb.NullValue.NULL_VALUE);
    }
    if (value is bool) {
      return structpb.Value(boolValue: value);
    }
    if (value is num) {
      return structpb.Value(numberValue: value.toDouble());
    }
    if (value is Map<String, Object?>) {
      return structpb.Value(structValue: _toStruct(value));
    }
    if (value is Iterable<Object?>) {
      return structpb.Value(
        listValue: structpb.ListValue(values: value.map(_toValue)),
      );
    }
    return structpb.Value(stringValue: value.toString());
  }
}
