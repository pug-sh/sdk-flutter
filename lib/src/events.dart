import 'dart:convert';

import 'contracts.dart';

class Event {
  const Event({
    required this.eventId,
    required this.projectId,
    required this.kind,
    required this.sessionId,
    required this.distinctId,
    required this.occurTime,
    required this.customProperties,
    required this.autoProperties,
  });

  final String eventId;
  final String projectId;
  final String kind;
  final String sessionId;
  final String distinctId;
  final int occurTime;
  final Map<String, PropertyValue> customProperties;
  final Map<String, PropertyValue> autoProperties;

  Map<String, Object?> toJson() => {
    'eventId': eventId,
    'projectId': projectId,
    'kind': kind,
    'sessionId': sessionId,
    'distinctId': distinctId,
    'occurTime': occurTime,
    'customProperties': customProperties.map(
      (key, value) => MapEntry(key, value.toJson()),
    ),
    'autoProperties': autoProperties.map(
      (key, value) => MapEntry(key, value.toJson()),
    ),
  };

  static Event fromJson(Map<String, Object?> json) {
    return Event(
      eventId: json['eventId']! as String,
      projectId: json['projectId']! as String,
      kind: json['kind']! as String,
      sessionId: json['sessionId']! as String,
      distinctId: json['distinctId']! as String,
      occurTime: json['occurTime']! as int,
      customProperties: _propertiesFromJson(json['customProperties']),
      autoProperties: _propertiesFromJson(json['autoProperties']),
    );
  }

  static Map<String, PropertyValue> _propertiesFromJson(Object? value) {
    if (value is! Map<Object?, Object?>) {
      return const {};
    }
    final properties = <String, PropertyValue>{};
    for (final entry in value.entries) {
      final property = entry.value;
      if (property is Map<Object?, Object?>) {
        properties[entry.key.toString()] = PropertyValue.fromJson(
          _stringObjectMap(property),
        );
      }
    }
    return properties;
  }
}

class PropertyValue {
  const PropertyValue._(this.kind, this.value);

  factory PropertyValue.string(String value) =>
      PropertyValue._('stringValue', value);
  factory PropertyValue.bool(bool value) => PropertyValue._('boolValue', value);
  factory PropertyValue.int(int value) => PropertyValue._('intValue', value);
  factory PropertyValue.double(double value) =>
      PropertyValue._('doubleValue', value);
  factory PropertyValue.timestamp(int millis) =>
      PropertyValue._('timestampValue', millis);

  final String kind;
  final Object value;

  Map<String, Object> toJson() => {kind: value};

  static PropertyValue fromJson(Map<String, Object?> json) {
    final entry = json.entries.first;
    final value = entry.value;
    return switch (entry.key) {
      'boolValue' => PropertyValue.bool(value! as bool),
      'intValue' => PropertyValue.int(value! as int),
      'doubleValue' => PropertyValue.double((value! as num).toDouble()),
      'timestampValue' => PropertyValue.timestamp(value! as int),
      _ => PropertyValue.string(value.toString()),
    };
  }
}

class PropertyMapper {
  const PropertyMapper({this.logger = const NoopPugLogger()});

  final PugLogger logger;

  Map<String, PropertyValue> mapProperties(Map<String, Object?> properties) {
    final mapped = <String, PropertyValue>{};
    for (final entry in properties.entries) {
      final value = _mapValue(entry.value);
      if (value != null) {
        mapped[entry.key] = value;
      }
    }
    return mapped;
  }

  Map<String, PropertyValue>? mapEventProperties(
    String kind,
    Map<String, Object?> properties,
  ) {
    final custom = <String, Object?>{};
    for (final MapEntry(:key, :value) in properties.entries) {
      if (value != null && key.startsWith(r'$')) {
        logger.warn(
          'Pug dropped property "$key" on event "$kind": keys starting with '
          '"\$" are reserved for auto-properties.',
        );
        continue;
      }
      custom[key] = value;
    }
    return mapProperties(custom);
  }

  Map<String, PropertyValue> mapAutoProperties(
    Map<String, Object?> properties,
  ) {
    final auto = <String, Object?>{};
    for (final MapEntry(:key, :value) in properties.entries) {
      if (value != null && !key.startsWith(r'$')) {
        logger.warn(
          'Pug dropped auto-property "$key": auto-property keys must start '
          'with "\$".',
        );
        continue;
      }
      auto[key] = value;
    }
    return mapProperties(auto);
  }

  PropertyValue? _mapValue(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is String) {
      return PropertyValue.string(_truncateUtf8(value, 1024));
    }
    if (value is bool) {
      return PropertyValue.bool(value);
    }
    if (value is int) {
      return PropertyValue.int(value);
    }
    if (value is double) {
      return value.isFinite
          ? PropertyValue.double(value)
          : _dropUnsupported(value);
    }
    if (value is num) {
      return value.isFinite
          ? PropertyValue.double(value.toDouble())
          : _dropUnsupported(value);
    }
    if (value is DateTime) {
      return PropertyValue.timestamp(value.toUtc().millisecondsSinceEpoch);
    }
    if (value is Duration) {
      return PropertyValue.string(_durationText(value));
    }
    if (value is Iterable || value is Map) {
      try {
        return PropertyValue.string(_truncateUtf8(jsonEncode(value), 1024));
      } catch (_, stackTrace) {
        logger.warn(
          'Pug could not JSON encode property value of type ${value.runtimeType}.',
        );
        logger.debug(stackTrace.toString());
        return _dropUnsupported(value);
      }
    }
    try {
      return PropertyValue.string(_truncateUtf8(jsonEncode(value), 1024));
    } catch (_, stackTrace) {
      logger.warn(
        'Pug could not JSON encode property value of type ${value.runtimeType}.',
      );
      logger.debug(stackTrace.toString());
      return _dropUnsupported(value);
    }
  }

  PropertyValue? _dropUnsupported(Object value) {
    logger.warn(
      'Pug dropped unsupported property value of type ${value.runtimeType}.',
    );
    return null;
  }

  String _truncateUtf8(String value, int maxBytes) {
    final bytes = utf8.encode(value);
    if (bytes.length <= maxBytes) {
      return value;
    }
    return utf8.decode(bytes.take(maxBytes).toList(), allowMalformed: true);
  }
}

// options.proto's text form for a google.protobuf.Duration ("0s", "1.5s"),
// rounded to the millisecond as sdk-android and sdk-ios send it, so one
// duration is one value across SDKs.
String _durationText(Duration duration) {
  final micros = duration.inMicroseconds;
  final millis = (micros.abs() + 500) ~/ 1000;
  final sign = micros < 0 && millis > 0 ? '-' : '';
  final seconds = millis ~/ 1000;
  final fraction = millis % 1000;
  if (fraction == 0) {
    return '$sign${seconds}s';
  }
  final digits = fraction
      .toString()
      .padLeft(3, '0')
      .replaceFirst(RegExp(r'0+$'), '');
  return '$sign$seconds.${digits}s';
}

enum WellKnownPropertyType {
  string('a string'),
  int32('an integer'),
  double('a finite number'),
  bool('a boolean'),
  duration('a duration');

  const WellKnownPropertyType(this.description);

  final String description;
}

class WellKnownPropertyField {
  const WellKnownPropertyField(this.type);

  final WellKnownPropertyType type;
}

class WellKnownEventSchema {
  const WellKnownEventSchema(this.fields);

  final Map<String, WellKnownPropertyField> fields;
}

class IdentifyRequest {
  const IdentifyRequest({
    required this.projectId,
    required this.externalId,
    required this.traits,
    this.anonymousId,
    this.deviceId,
  });

  final String projectId;
  final String externalId;
  final String? anonymousId;
  final String? deviceId;
  final Map<String, PropertyValue> traits;
}

Map<String, Object?> _stringObjectMap(Map<Object?, Object?> value) {
  final typed = <String, Object?>{};
  for (final entry in value.entries) {
    final key = entry.key;
    if (key is String) {
      typed[key] = entry.value;
    }
  }
  return typed;
}
