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
    return mapProperties(properties);
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
const _boolField = WellKnownPropertyField(WellKnownPropertyType.bool);
const _doubleField = WellKnownPropertyField(WellKnownPropertyType.double);

const wellKnownEventSchemas = <String, WellKnownEventSchema>{
  'add_to_cart': WellKnownEventSchema({
    'productId': _stringField,
    'price': _doubleField,
    'currency': _stringField,
    'cartId': _stringField,
    'quantity': _intField,
    'category': _stringField,
    'brand': _stringField,
    'sku': _stringField,
  }),
  'api_key_created': WellKnownEventSchema({
    'apiKeyId': _stringField,
    'name': _stringField,
    'scope': _stringField,
  }),
  'api_key_revoked': WellKnownEventSchema({
    'apiKeyId': _stringField,
    'name': _stringField,
    'reason': _stringField,
  }),
  'app_backgrounded': WellKnownEventSchema({}),
  'app_close': WellKnownEventSchema({}),
  'app_crashed': WellKnownEventSchema({
    'errorMessage': _stringField,
    'errorType': _stringField,
  }),
  'app_foregrounded': WellKnownEventSchema({}),
  'app_install': WellKnownEventSchema({
    'appVersion': _stringField,
    'installSource': _stringField,
  }),
  'app_open': WellKnownEventSchema({}),
  'app_update': WellKnownEventSchema({
    'appVersion': _stringField,
    'previousVersion': _stringField,
  }),
  'audio_completed': WellKnownEventSchema({'audioId': _stringField}),
  'audio_pause': WellKnownEventSchema({'audioId': _stringField}),
  'audio_play': WellKnownEventSchema({'audioId': _stringField}),
  'audio_seeked': WellKnownEventSchema({'audioId': _stringField}),
  'audio_started': WellKnownEventSchema({'audioId': _stringField}),
  'cart_viewed': WellKnownEventSchema({
    'cartId': _stringField,
    'itemCount': _intField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'chat_archived': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
  }),
  'chat_attachment_downloaded': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'attachmentId': _stringField,
    'attachmentType': _stringField,
    'sizeBytes': _intField,
    'threadId': _stringField,
  }),
  'chat_attachment_uploaded': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'attachmentId': _stringField,
    'attachmentType': _stringField,
    'sizeBytes': _intField,
    'threadId': _stringField,
  }),
  'chat_call_joined': WellKnownEventSchema({
    'conversationId': _stringField,
    'callId': _stringField,
    'callType': _stringField,
  }),
  'chat_call_left': WellKnownEventSchema({
    'conversationId': _stringField,
    'callId': _stringField,
    'callType': _stringField,
  }),
  'chat_call_recording_started': WellKnownEventSchema({
    'conversationId': _stringField,
    'callId': _stringField,
  }),
  'chat_call_screen_shared': WellKnownEventSchema({
    'conversationId': _stringField,
    'callId': _stringField,
  }),
  'chat_call_started': WellKnownEventSchema({
    'conversationId': _stringField,
    'callId': _stringField,
    'callType': _stringField,
  }),
  'chat_created': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
    'participantCount': _intField,
  }),
  'chat_deleted': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
    'reason': _stringField,
  }),
  'chat_joined': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
  }),
  'chat_left': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
    'reason': _stringField,
  }),
  'chat_member_added': WellKnownEventSchema({
    'conversationId': _stringField,
    'memberId': _stringField,
    'role': _stringField,
  }),
  'chat_member_muted': WellKnownEventSchema({
    'conversationId': _stringField,
    'memberId': _stringField,
  }),
  'chat_member_removed': WellKnownEventSchema({
    'conversationId': _stringField,
    'memberId': _stringField,
    'reason': _stringField,
  }),
  'chat_member_role_changed': WellKnownEventSchema({
    'conversationId': _stringField,
    'memberId': _stringField,
    'previousRole': _stringField,
    'newRole': _stringField,
  }),
  'chat_message_deleted': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'reason': _stringField,
    'threadId': _stringField,
  }),
  'chat_message_edited': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'threadId': _stringField,
  }),
  'chat_message_failed': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'reason': _stringField,
    'threadId': _stringField,
  }),
  'chat_message_pinned': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'threadId': _stringField,
  }),
  'chat_message_read': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'threadId': _stringField,
  }),
  'chat_message_received': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'messageType': _stringField,
    'characterCount': _intField,
    'attachmentCount': _intField,
    'threadId': _stringField,
    'parentMessageId': _stringField,
  }),
  'chat_message_sent': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'messageType': _stringField,
    'characterCount': _intField,
    'attachmentCount': _intField,
    'threadId': _stringField,
    'parentMessageId': _stringField,
  }),
  'chat_message_unpinned': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'conversationType': _stringField,
    'threadId': _stringField,
  }),
  'chat_reaction_added': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'reaction': _stringField,
    'threadId': _stringField,
  }),
  'chat_reaction_removed': WellKnownEventSchema({
    'conversationId': _stringField,
    'messageId': _stringField,
    'reaction': _stringField,
    'threadId': _stringField,
  }),
  'chat_typing_started': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
  }),
  'chat_typing_stopped': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
  }),
  'chat_unarchived': WellKnownEventSchema({
    'conversationId': _stringField,
    'conversationType': _stringField,
  }),
  'chat_user_blocked': WellKnownEventSchema({'userId': _stringField}),
  'checkout_started': WellKnownEventSchema({
    'productId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
    'cartId': _stringField,
    'checkoutId': _stringField,
    'itemCount': _intField,
  }),
  'checkout_step_completed': WellKnownEventSchema({
    'checkoutId': _stringField,
    'step': _stringField,
    'stepIndex': _intField,
  }),
  'coupon_applied': WellKnownEventSchema({
    'couponId': _stringField,
    'couponCode': _stringField,
    'cartId': _stringField,
    'discountAmount': _doubleField,
    'currency': _stringField,
  }),
  'coupon_removed': WellKnownEventSchema({
    'couponId': _stringField,
    'couponCode': _stringField,
    'cartId': _stringField,
    'reason': _stringField,
  }),
  'email_verified': WellKnownEventSchema({}),
  'error_occurred': WellKnownEventSchema({
    'errorCode': _stringField,
    'message': _stringField,
    'severity': _stringField,
    'unhandled': _boolField,
    'stack': _stringField,
  }),
  'export_completed': WellKnownEventSchema({
    'exportId': _stringField,
    'exportType': _stringField,
    'sizeBytes': _intField,
  }),
  'export_started': WellKnownEventSchema({
    'exportId': _stringField,
    'exportType': _stringField,
  }),
  'feature_used': WellKnownEventSchema({
    'featureId': _stringField,
    'featureName': _stringField,
  }),
  'feedback_submitted': WellKnownEventSchema({
    'feedbackId': _stringField,
    'category': _stringField,
    'comment': _stringField,
  }),
  'file_downloaded': WellKnownEventSchema({
    'fileId': _stringField,
    'fileName': _stringField,
    'fileType': _stringField,
    'sizeBytes': _intField,
  }),
  'file_uploaded': WellKnownEventSchema({
    'fileId': _stringField,
    'fileName': _stringField,
    'fileType': _stringField,
    'sizeBytes': _intField,
  }),
  'filter_applied': WellKnownEventSchema({
    'key': _stringField,
    'value': _stringField,
  }),
  'form_start': WellKnownEventSchema({
    'formId': _stringField,
    'formName': _stringField,
  }),
  'form_submit': WellKnownEventSchema({
    'formId': _stringField,
    'formName': _stringField,
    'action': _stringField,
  }),
  'help_article_viewed': WellKnownEventSchema({
    'articleId': _stringField,
    'articleTitle': _stringField,
    'category': _stringField,
  }),
  'integration_connected': WellKnownEventSchema({
    'integrationId': _stringField,
    'integrationType': _stringField,
  }),
  'integration_disconnected': WellKnownEventSchema({
    'integrationId': _stringField,
    'integrationType': _stringField,
    'reason': _stringField,
  }),
  'invite_accepted': WellKnownEventSchema({
    'inviteId': _stringField,
    'workspaceId': _stringField,
    'inviterId': _stringField,
    'inviteeId': _stringField,
    'inviteeEmail': _stringField,
    'role': _stringField,
  }),
  'invite_sent': WellKnownEventSchema({
    'inviteId': _stringField,
    'workspaceId': _stringField,
    'inviterId': _stringField,
    'inviteeId': _stringField,
    'inviteeEmail': _stringField,
    'role': _stringField,
  }),
  'invoice_failed': WellKnownEventSchema({
    'invoiceId': _stringField,
    'subscriptionId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
    'reason': _stringField,
  }),
  'invoice_paid': WellKnownEventSchema({
    'invoiceId': _stringField,
    'subscriptionId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'mfa_disabled': WellKnownEventSchema({'method': _stringField}),
  'mfa_enabled': WellKnownEventSchema({'method': _stringField}),
  'notification_clicked': WellKnownEventSchema({
    'campaignId': _stringField,
    'notificationType': _stringField,
  }),
  'notification_dismissed': WellKnownEventSchema({
    'campaignId': _stringField,
    'notificationType': _stringField,
  }),
  'notification_received': WellKnownEventSchema({
    'campaignId': _stringField,
    'notificationType': _stringField,
  }),
  'nps_submitted': WellKnownEventSchema({
    'score': _intField,
    'comment': _stringField,
  }),
  'order_refunded': WellKnownEventSchema({
    'orderId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
    'reason': _stringField,
  }),
  'password_reset_completed': WellKnownEventSchema({}),
  'password_reset_requested': WellKnownEventSchema({}),
  'payment_failed': WellKnownEventSchema({
    'paymentId': _stringField,
    'invoiceId': _stringField,
    'subscriptionId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
    'reason': _stringField,
  }),
  'payment_method_added': WellKnownEventSchema({
    'paymentMethodId': _stringField,
    'paymentMethodType': _stringField,
  }),
  'payment_method_removed': WellKnownEventSchema({
    'paymentMethodId': _stringField,
    'paymentMethodType': _stringField,
  }),
  'payment_succeeded': WellKnownEventSchema({
    'paymentId': _stringField,
    'invoiceId': _stringField,
    'subscriptionId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'product_list_viewed': WellKnownEventSchema({
    'listId': _stringField,
    'listName': _stringField,
    'category': _stringField,
    'itemCount': _intField,
  }),
  'product_viewed': WellKnownEventSchema({
    'productId': _stringField,
    'productName': _stringField,
    'category': _stringField,
    'brand': _stringField,
    'sku': _stringField,
    'price': _doubleField,
    'currency': _stringField,
  }),
  'purchase': WellKnownEventSchema({
    'productId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
    'orderId': _stringField,
    'quantity': _intField,
    'category': _stringField,
    'brand': _stringField,
    'sku': _stringField,
  }),
  'recommendation_clicked': WellKnownEventSchema({
    'recommendationId': _stringField,
    'itemId': _stringField,
    'source': _stringField,
    'index': _intField,
  }),
  'recommendation_viewed': WellKnownEventSchema({
    'recommendationId': _stringField,
    'itemId': _stringField,
    'source': _stringField,
    'index': _intField,
  }),
  'refund_failed': WellKnownEventSchema({
    'orderId': _stringField,
    'refundId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
    'reason': _stringField,
  }),
  'remove_from_cart': WellKnownEventSchema({
    'productId': _stringField,
    'price': _doubleField,
    'currency': _stringField,
    'cartId': _stringField,
    'quantity': _intField,
    'category': _stringField,
    'brand': _stringField,
    'sku': _stringField,
  }),
  'screen_view': WellKnownEventSchema({
    'screenName': _stringField,
    'screenClass': _stringField,
  }),
  'scroll': WellKnownEventSchema({'percent': _intField, 'scrollY': _intField}),
  'search': WellKnownEventSchema({'query': _stringField}),
  'search_result_clicked': WellKnownEventSchema({
    'query': _stringField,
    'resultId': _stringField,
    'index': _intField,
  }),
  'share': WellKnownEventSchema({}),
  'signin': WellKnownEventSchema({}),
  'signout': WellKnownEventSchema({}),
  'signup': WellKnownEventSchema({}),
  'sort_changed': WellKnownEventSchema({
    'key': _stringField,
    'direction': _stringField,
  }),
  'subscription_canceled': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'planId': _stringField,
    'reason': _stringField,
  }),
  'subscription_changed': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'previousPlanId': _stringField,
    'newPlanId': _stringField,
  }),
  'subscription_paused': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'planId': _stringField,
    'reason': _stringField,
  }),
  'subscription_renewed': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'planId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'subscription_resumed': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'planId': _stringField,
    'reason': _stringField,
  }),
  'subscription_started': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'planId': _stringField,
    'amount': _doubleField,
    'currency': _stringField,
  }),
  'subscription_trial_will_end': WellKnownEventSchema({
    'subscriptionId': _stringField,
    'planId': _stringField,
    'trialId': _stringField,
  }),
  'support_chat_started': WellKnownEventSchema({
    'conversationId': _stringField,
    'topic': _stringField,
  }),
  'support_ticket_created': WellKnownEventSchema({
    'ticketId': _stringField,
    'category': _stringField,
    'priority': _stringField,
  }),
  'support_ticket_resolved': WellKnownEventSchema({
    'ticketId': _stringField,
    'resolution': _stringField,
  }),
  'survey_completed': WellKnownEventSchema({
    'surveyId': _stringField,
    'questionCount': _intField,
  }),
  'survey_started': WellKnownEventSchema({'surveyId': _stringField}),
  'trial_converted': WellKnownEventSchema({
    'trialId': _stringField,
    'subscriptionId': _stringField,
    'planId': _stringField,
  }),
  'trial_started': WellKnownEventSchema({
    'trialId': _stringField,
    'planId': _stringField,
  }),
  'video_completed': WellKnownEventSchema({'videoId': _stringField}),
  'video_pause': WellKnownEventSchema({'videoId': _stringField}),
  'video_play': WellKnownEventSchema({'videoId': _stringField}),
  'video_seeked': WellKnownEventSchema({'videoId': _stringField}),
  'video_started': WellKnownEventSchema({'videoId': _stringField}),
  'wishlist_added': WellKnownEventSchema({
    'productId': _stringField,
    'wishlistId': _stringField,
    'price': _doubleField,
    'currency': _stringField,
  }),
  'wishlist_removed': WellKnownEventSchema({
    'productId': _stringField,
    'wishlistId': _stringField,
  }),
  'workspace_created': WellKnownEventSchema({
    'workspaceId': _stringField,
    'workspaceName': _stringField,
  }),
  'workspace_deleted': WellKnownEventSchema({
    'workspaceId': _stringField,
    'reason': _stringField,
  }),
  'workspace_joined': WellKnownEventSchema({
    'workspaceId': _stringField,
    'role': _stringField,
  }),
  'workspace_role_changed': WellKnownEventSchema({
    'workspaceId': _stringField,
    'memberId': _stringField,
    'previousRole': _stringField,
    'newRole': _stringField,
  }),
  'workspace_settings_updated': WellKnownEventSchema({
    'workspaceId': _stringField,
    'setting': _stringField,
  }),
};

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
