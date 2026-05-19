// This is a generated file - do not edit.
//
// Generated from shared/delivery/v1/delivery.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import 'delivery.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'delivery.pbenum.dart';

class BatchDeliveryEvents extends $pb.GeneratedMessage {
  factory BatchDeliveryEvents({
    $core.Iterable<DeliveryEventMessage>? events,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    return result;
  }

  BatchDeliveryEvents._();

  factory BatchDeliveryEvents.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchDeliveryEvents.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchDeliveryEvents',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..pPM<DeliveryEventMessage>(1, _omitFieldNames ? '' : 'events',
        subBuilder: DeliveryEventMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchDeliveryEvents clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchDeliveryEvents copyWith(void Function(BatchDeliveryEvents) updates) =>
      super.copyWith((message) => updates(message as BatchDeliveryEvents))
          as BatchDeliveryEvents;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchDeliveryEvents create() => BatchDeliveryEvents._();
  @$core.override
  BatchDeliveryEvents createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchDeliveryEvents getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchDeliveryEvents>(create);
  static BatchDeliveryEvents? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeliveryEventMessage> get events => $_getList(0);
}

class BatchMulticastMessage extends $pb.GeneratedMessage {
  factory BatchMulticastMessage({
    $core.String? body,
    $core.String? campaignId,
    $core.String? image,
    $core.String? projectId,
    $core.Iterable<DeviceToken>? deviceTokens,
    $core.String? title,
  }) {
    final result = create();
    if (body != null) result.body = body;
    if (campaignId != null) result.campaignId = campaignId;
    if (image != null) result.image = image;
    if (projectId != null) result.projectId = projectId;
    if (deviceTokens != null) result.deviceTokens.addAll(deviceTokens);
    if (title != null) result.title = title;
    return result;
  }

  BatchMulticastMessage._();

  factory BatchMulticastMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchMulticastMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchMulticastMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'body')
    ..aOS(2, _omitFieldNames ? '' : 'campaignId')
    ..aOS(3, _omitFieldNames ? '' : 'image')
    ..aOS(4, _omitFieldNames ? '' : 'projectId')
    ..pPM<DeviceToken>(5, _omitFieldNames ? '' : 'deviceTokens',
        subBuilder: DeviceToken.create)
    ..aOS(6, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchMulticastMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchMulticastMessage copyWith(
          void Function(BatchMulticastMessage) updates) =>
      super.copyWith((message) => updates(message as BatchMulticastMessage))
          as BatchMulticastMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchMulticastMessage create() => BatchMulticastMessage._();
  @$core.override
  BatchMulticastMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchMulticastMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchMulticastMessage>(create);
  static BatchMulticastMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get body => $_getSZ(0);
  @$pb.TagNumber(1)
  set body($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBody() => $_has(0);
  @$pb.TagNumber(1)
  void clearBody() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get campaignId => $_getSZ(1);
  @$pb.TagNumber(2)
  set campaignId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCampaignId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCampaignId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get image => $_getSZ(2);
  @$pb.TagNumber(3)
  set image($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get projectId => $_getSZ(3);
  @$pb.TagNumber(4)
  set projectId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProjectId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProjectId() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<DeviceToken> get deviceTokens => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(6)
  set title($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTitle() => $_clearField(6);
}

class BatchUnicastMessage extends $pb.GeneratedMessage {
  factory BatchUnicastMessage() => create();

  BatchUnicastMessage._();

  factory BatchUnicastMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchUnicastMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchUnicastMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchUnicastMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchUnicastMessage copyWith(void Function(BatchUnicastMessage) updates) =>
      super.copyWith((message) => updates(message as BatchUnicastMessage))
          as BatchUnicastMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchUnicastMessage create() => BatchUnicastMessage._();
  @$core.override
  BatchUnicastMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchUnicastMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchUnicastMessage>(create);
  static BatchUnicastMessage? _defaultInstance;
}

class DeliveryEvent extends $pb.GeneratedMessage {
  factory DeliveryEvent({
    $fixnum.Int64? eventCount,
    EventType? eventType,
    Platform? platform,
    $0.Timestamp? timestamp,
  }) {
    final result = create();
    if (eventCount != null) result.eventCount = eventCount;
    if (eventType != null) result.eventType = eventType;
    if (platform != null) result.platform = platform;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  DeliveryEvent._();

  factory DeliveryEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeliveryEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeliveryEvent',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'eventCount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<EventType>(2, _omitFieldNames ? '' : 'eventType',
        enumValues: EventType.values)
    ..aE<Platform>(3, _omitFieldNames ? '' : 'platform',
        enumValues: Platform.values)
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeliveryEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeliveryEvent copyWith(void Function(DeliveryEvent) updates) =>
      super.copyWith((message) => updates(message as DeliveryEvent))
          as DeliveryEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeliveryEvent create() => DeliveryEvent._();
  @$core.override
  DeliveryEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeliveryEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeliveryEvent>(create);
  static DeliveryEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get eventCount => $_getI64(0);
  @$pb.TagNumber(1)
  set eventCount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventCount() => $_clearField(1);

  @$pb.TagNumber(2)
  EventType get eventType => $_getN(1);
  @$pb.TagNumber(2)
  set eventType(EventType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventType() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventType() => $_clearField(2);

  @$pb.TagNumber(3)
  Platform get platform => $_getN(2);
  @$pb.TagNumber(3)
  set platform(Platform value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPlatform() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlatform() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(4)
  set timestamp($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureTimestamp() => $_ensure(3);
}

class DeliveryEventMessage extends $pb.GeneratedMessage {
  factory DeliveryEventMessage({
    $core.String? campaignId,
    $0.Timestamp? eventTimestamp,
    EventType? eventType,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.String? messageId,
    Platform? platform,
    $core.String? projectId,
    $core.String? deviceId,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (eventTimestamp != null) result.eventTimestamp = eventTimestamp;
    if (eventType != null) result.eventType = eventType;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (messageId != null) result.messageId = messageId;
    if (platform != null) result.platform = platform;
    if (projectId != null) result.projectId = projectId;
    if (deviceId != null) result.deviceId = deviceId;
    return result;
  }

  DeliveryEventMessage._();

  factory DeliveryEventMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeliveryEventMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeliveryEventMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'eventTimestamp',
        subBuilder: $0.Timestamp.create)
    ..aE<EventType>(3, _omitFieldNames ? '' : 'eventType',
        enumValues: EventType.values)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'DeliveryEventMessage.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('shared.delivery.v1'))
    ..aOS(5, _omitFieldNames ? '' : 'messageId')
    ..aE<Platform>(6, _omitFieldNames ? '' : 'platform',
        enumValues: Platform.values)
    ..aOS(7, _omitFieldNames ? '' : 'projectId')
    ..aOS(8, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeliveryEventMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeliveryEventMessage copyWith(void Function(DeliveryEventMessage) updates) =>
      super.copyWith((message) => updates(message as DeliveryEventMessage))
          as DeliveryEventMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeliveryEventMessage create() => DeliveryEventMessage._();
  @$core.override
  DeliveryEventMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeliveryEventMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeliveryEventMessage>(create);
  static DeliveryEventMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get eventTimestamp => $_getN(1);
  @$pb.TagNumber(2)
  set eventTimestamp($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventTimestamp() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureEventTimestamp() => $_ensure(1);

  @$pb.TagNumber(3)
  EventType get eventType => $_getN(2);
  @$pb.TagNumber(3)
  set eventType(EventType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);

  @$pb.TagNumber(5)
  $core.String get messageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set messageId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessageId() => $_clearField(5);

  @$pb.TagNumber(6)
  Platform get platform => $_getN(5);
  @$pb.TagNumber(6)
  set platform(Platform value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPlatform() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlatform() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get projectId => $_getSZ(6);
  @$pb.TagNumber(7)
  set projectId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProjectId() => $_has(6);
  @$pb.TagNumber(7)
  void clearProjectId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get deviceId => $_getSZ(7);
  @$pb.TagNumber(8)
  set deviceId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDeviceId() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeviceId() => $_clearField(8);
}

class RecordEventRequest extends $pb.GeneratedMessage {
  factory RecordEventRequest({
    $core.String? campaignId,
    $0.Timestamp? eventTimestamp,
    EventType? eventType,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.String? messageId,
    Platform? platform,
    $core.String? deviceId,
  }) {
    final result = create();
    if (campaignId != null) result.campaignId = campaignId;
    if (eventTimestamp != null) result.eventTimestamp = eventTimestamp;
    if (eventType != null) result.eventType = eventType;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (messageId != null) result.messageId = messageId;
    if (platform != null) result.platform = platform;
    if (deviceId != null) result.deviceId = deviceId;
    return result;
  }

  RecordEventRequest._();

  factory RecordEventRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordEventRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordEventRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'campaignId')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'eventTimestamp',
        subBuilder: $0.Timestamp.create)
    ..aE<EventType>(3, _omitFieldNames ? '' : 'eventType',
        enumValues: EventType.values)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'RecordEventRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('shared.delivery.v1'))
    ..aOS(5, _omitFieldNames ? '' : 'messageId')
    ..aE<Platform>(6, _omitFieldNames ? '' : 'platform',
        enumValues: Platform.values)
    ..aOS(7, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordEventRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordEventRequest copyWith(void Function(RecordEventRequest) updates) =>
      super.copyWith((message) => updates(message as RecordEventRequest))
          as RecordEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordEventRequest create() => RecordEventRequest._();
  @$core.override
  RecordEventRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordEventRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordEventRequest>(create);
  static RecordEventRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get campaignId => $_getSZ(0);
  @$pb.TagNumber(1)
  set campaignId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCampaignId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCampaignId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get eventTimestamp => $_getN(1);
  @$pb.TagNumber(2)
  set eventTimestamp($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEventTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventTimestamp() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureEventTimestamp() => $_ensure(1);

  @$pb.TagNumber(3)
  EventType get eventType => $_getN(2);
  @$pb.TagNumber(3)
  set eventType(EventType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);

  @$pb.TagNumber(5)
  $core.String get messageId => $_getSZ(4);
  @$pb.TagNumber(5)
  set messageId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessageId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessageId() => $_clearField(5);

  @$pb.TagNumber(6)
  Platform get platform => $_getN(5);
  @$pb.TagNumber(6)
  set platform(Platform value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPlatform() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlatform() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get deviceId => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeviceId() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceId() => $_clearField(7);
}

class RecordEventResponse extends $pb.GeneratedMessage {
  factory RecordEventResponse({
    $core.String? message,
    $core.int? retryAfterSeconds,
    $core.bool? shouldRetry,
    $core.bool? success,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (retryAfterSeconds != null) result.retryAfterSeconds = retryAfterSeconds;
    if (shouldRetry != null) result.shouldRetry = shouldRetry;
    if (success != null) result.success = success;
    return result;
  }

  RecordEventResponse._();

  factory RecordEventResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordEventResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordEventResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aI(2, _omitFieldNames ? '' : 'retryAfterSeconds')
    ..aOB(3, _omitFieldNames ? '' : 'shouldRetry')
    ..aOB(4, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordEventResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordEventResponse copyWith(void Function(RecordEventResponse) updates) =>
      super.copyWith((message) => updates(message as RecordEventResponse))
          as RecordEventResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordEventResponse create() => RecordEventResponse._();
  @$core.override
  RecordEventResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordEventResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordEventResponse>(create);
  static RecordEventResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get retryAfterSeconds => $_getIZ(1);
  @$pb.TagNumber(2)
  set retryAfterSeconds($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRetryAfterSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearRetryAfterSeconds() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get shouldRetry => $_getBF(2);
  @$pb.TagNumber(3)
  set shouldRetry($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasShouldRetry() => $_has(2);
  @$pb.TagNumber(3)
  void clearShouldRetry() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get success => $_getBF(3);
  @$pb.TagNumber(4)
  set success($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSuccess() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccess() => $_clearField(4);
}

class DeviceToken extends $pb.GeneratedMessage {
  factory DeviceToken({
    $core.String? deviceId,
    $core.String? token,
  }) {
    final result = create();
    if (deviceId != null) result.deviceId = deviceId;
    if (token != null) result.token = token;
    return result;
  }

  DeviceToken._();

  factory DeviceToken.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceToken.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceToken',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'shared.delivery.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceId')
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceToken clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceToken copyWith(void Function(DeviceToken) updates) =>
      super.copyWith((message) => updates(message as DeviceToken))
          as DeviceToken;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceToken create() => DeviceToken._();
  @$core.override
  DeviceToken createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceToken getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceToken>(create);
  static DeviceToken? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => $_clearField(2);
}

class DeliveryServiceApi {
  final $pb.RpcClient _client;

  DeliveryServiceApi(this._client);

  $async.Future<RecordEventResponse> recordEvent(
          $pb.ClientContext? ctx, RecordEventRequest request) =>
      _client.invoke<RecordEventResponse>(ctx, 'DeliveryService', 'RecordEvent',
          request, RecordEventResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
