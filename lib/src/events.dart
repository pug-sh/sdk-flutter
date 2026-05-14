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
    final schema = wellKnownEventSchemas[kind];
    if (schema == null) {
      return mapProperties(properties);
    }

    final mapped = <String, PropertyValue>{};
    for (final entry in properties.entries) {
      final field = schema.fields[entry.key];
      if (field == null) {
        final value = _mapValue(entry.value);
        if (value != null) {
          mapped[entry.key] = value;
        }
        continue;
      }

      final value = _mapKnownValue(entry.value, field);
      if (value == null) {
        logger.error(
          'Pug dropped "$kind": property "${entry.key}" must be ${field.type.description}.',
        );
        return null;
      }
      mapped[entry.key] = value;
    }
    return mapped;
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
    if (value is Iterable || value is Map) {
      try {
        return PropertyValue.string(_truncateUtf8(jsonEncode(value), 1024));
      } catch (_) {
        return _dropUnsupported(value);
      }
    }
    try {
      return PropertyValue.string(_truncateUtf8(jsonEncode(value), 1024));
    } catch (_) {
      return _dropUnsupported(value);
    }
  }

  PropertyValue? _mapKnownValue(Object? value, WellKnownPropertyField field) {
    if (value == null) {
      return null;
    }
    return switch (field.type) {
      WellKnownPropertyType.string =>
        value is String
            ? PropertyValue.string(_truncateUtf8(value, 1024))
            : null,
      WellKnownPropertyType.int32 =>
        value is int ? PropertyValue.int(value) : null,
      WellKnownPropertyType.double =>
        value is num && value.isFinite
            ? PropertyValue.double(value.toDouble())
            : null,
      WellKnownPropertyType.bool =>
        value is bool ? PropertyValue.bool(value) : null,
    };
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

enum WellKnownPropertyType {
  string('a string'),
  int32('an integer'),
  double('a finite number'),
  bool('a boolean');

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

const _stringField = WellKnownPropertyField(WellKnownPropertyType.string);
const _intField = WellKnownPropertyField(WellKnownPropertyType.int32);
const _doubleField = WellKnownPropertyField(WellKnownPropertyType.double);

const wellKnownEventSchemas = <String, WellKnownEventSchema>{
  'page_view': WellKnownEventSchema({}),
  'click': WellKnownEventSchema({
    'class': _stringField,
    'id': _stringField,
    'tag': _stringField,
    'text': _stringField,
    'x': _intField,
    'y': _intField,
  }),
  'rage_click': WellKnownEventSchema({
    'clickCount': _intField,
    'element': _stringField,
    'x': _intField,
    'y': _intField,
  }),
  'dead_click': WellKnownEventSchema({
    'element': _stringField,
    'text': _stringField,
    'x': _intField,
    'y': _intField,
  }),
  'scroll': WellKnownEventSchema({'percent': _intField, 'scrollY': _intField}),
  'search': WellKnownEventSchema({'query': _stringField}),
  'add_to_cart': WellKnownEventSchema({
    'productId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'checkout_started': WellKnownEventSchema({
    'productId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'checkout_completed': WellKnownEventSchema({
    'productId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'purchase': WellKnownEventSchema({
    'productId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'form_start': WellKnownEventSchema({
    'formId': _stringField,
    'formName': _stringField,
  }),
  'form_submit': WellKnownEventSchema({
    'action': _stringField,
    'formId': _stringField,
    'formName': _stringField,
  }),
  'signup': WellKnownEventSchema({}),
  'login': WellKnownEventSchema({}),
  'logout': WellKnownEventSchema({}),
  'app_open': WellKnownEventSchema({}),
  'app_close': WellKnownEventSchema({}),
  'notification_received': WellKnownEventSchema({
    'campaignId': _stringField,
    'notificationType': _stringField,
  }),
  'notification_clicked': WellKnownEventSchema({
    'campaignId': _stringField,
    'notificationType': _stringField,
  }),
  'notification_dismissed': WellKnownEventSchema({
    'campaignId': _stringField,
    'notificationType': _stringField,
  }),
  'video_play': WellKnownEventSchema({
    'videoId': _stringField,
    'positionS': _intField,
  }),
  'video_pause': WellKnownEventSchema({
    'videoId': _stringField,
    'positionS': _intField,
  }),
  'error_occurred': WellKnownEventSchema({'errorCode': _stringField}),
  'share': WellKnownEventSchema({}),
};

class IdentifyRequest {
  const IdentifyRequest({
    required this.projectId,
    required this.externalId,
    required this.deviceId,
    required this.traits,
    this.anonymousId,
  });

  final String projectId;
  final String externalId;
  final String? anonymousId;
  final String deviceId;
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
