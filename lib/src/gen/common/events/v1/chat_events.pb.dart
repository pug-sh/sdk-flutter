// This is a generated file - do not edit.
//
// Generated from common/events/v1/chat_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ChatCreatedProperties extends $pb.GeneratedMessage {
  factory ChatCreatedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
    $core.int? participantCount,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    if (participantCount != null) result.participantCount = participantCount;
    return result;
  }

  ChatCreatedProperties._();

  factory ChatCreatedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatCreatedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCreatedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..aI(3, _omitFieldNames ? '' : 'participantCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCreatedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCreatedProperties copyWith(
          void Function(ChatCreatedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatCreatedProperties))
          as ChatCreatedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCreatedProperties create() => ChatCreatedProperties._();
  @$core.override
  ChatCreatedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatCreatedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatCreatedProperties>(create);
  static ChatCreatedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get participantCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set participantCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasParticipantCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearParticipantCount() => $_clearField(3);
}

class ChatJoinedProperties extends $pb.GeneratedMessage {
  factory ChatJoinedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    return result;
  }

  ChatJoinedProperties._();

  factory ChatJoinedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatJoinedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatJoinedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatJoinedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatJoinedProperties copyWith(void Function(ChatJoinedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatJoinedProperties))
          as ChatJoinedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatJoinedProperties create() => ChatJoinedProperties._();
  @$core.override
  ChatJoinedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatJoinedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatJoinedProperties>(create);
  static ChatJoinedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);
}

class ChatLeftProperties extends $pb.GeneratedMessage {
  factory ChatLeftProperties({
    $core.String? conversationId,
    $core.String? conversationType,
    $core.String? reason,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    if (reason != null) result.reason = reason;
    return result;
  }

  ChatLeftProperties._();

  factory ChatLeftProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatLeftProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatLeftProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatLeftProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatLeftProperties copyWith(void Function(ChatLeftProperties) updates) =>
      super.copyWith((message) => updates(message as ChatLeftProperties))
          as ChatLeftProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatLeftProperties create() => ChatLeftProperties._();
  @$core.override
  ChatLeftProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatLeftProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatLeftProperties>(create);
  static ChatLeftProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class ChatDeletedProperties extends $pb.GeneratedMessage {
  factory ChatDeletedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
    $core.String? reason,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    if (reason != null) result.reason = reason;
    return result;
  }

  ChatDeletedProperties._();

  factory ChatDeletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatDeletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatDeletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDeletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDeletedProperties copyWith(
          void Function(ChatDeletedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatDeletedProperties))
          as ChatDeletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatDeletedProperties create() => ChatDeletedProperties._();
  @$core.override
  ChatDeletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatDeletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatDeletedProperties>(create);
  static ChatDeletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class ChatArchivedProperties extends $pb.GeneratedMessage {
  factory ChatArchivedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    return result;
  }

  ChatArchivedProperties._();

  factory ChatArchivedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatArchivedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatArchivedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatArchivedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatArchivedProperties copyWith(
          void Function(ChatArchivedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatArchivedProperties))
          as ChatArchivedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatArchivedProperties create() => ChatArchivedProperties._();
  @$core.override
  ChatArchivedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatArchivedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatArchivedProperties>(create);
  static ChatArchivedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);
}

class ChatUnarchivedProperties extends $pb.GeneratedMessage {
  factory ChatUnarchivedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    return result;
  }

  ChatUnarchivedProperties._();

  factory ChatUnarchivedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatUnarchivedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatUnarchivedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatUnarchivedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatUnarchivedProperties copyWith(
          void Function(ChatUnarchivedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatUnarchivedProperties))
          as ChatUnarchivedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatUnarchivedProperties create() => ChatUnarchivedProperties._();
  @$core.override
  ChatUnarchivedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatUnarchivedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatUnarchivedProperties>(create);
  static ChatUnarchivedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);
}

class ChatMemberAddedProperties extends $pb.GeneratedMessage {
  factory ChatMemberAddedProperties({
    $core.String? conversationId,
    $core.String? memberId,
    $core.String? role,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (memberId != null) result.memberId = memberId;
    if (role != null) result.role = role;
    return result;
  }

  ChatMemberAddedProperties._();

  factory ChatMemberAddedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMemberAddedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMemberAddedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberAddedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberAddedProperties copyWith(
          void Function(ChatMemberAddedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatMemberAddedProperties))
          as ChatMemberAddedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMemberAddedProperties create() => ChatMemberAddedProperties._();
  @$core.override
  ChatMemberAddedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMemberAddedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMemberAddedProperties>(create);
  static ChatMemberAddedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);
}

class ChatMemberRemovedProperties extends $pb.GeneratedMessage {
  factory ChatMemberRemovedProperties({
    $core.String? conversationId,
    $core.String? memberId,
    $core.String? reason,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (memberId != null) result.memberId = memberId;
    if (reason != null) result.reason = reason;
    return result;
  }

  ChatMemberRemovedProperties._();

  factory ChatMemberRemovedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMemberRemovedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMemberRemovedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberRemovedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberRemovedProperties copyWith(
          void Function(ChatMemberRemovedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMemberRemovedProperties))
          as ChatMemberRemovedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMemberRemovedProperties create() =>
      ChatMemberRemovedProperties._();
  @$core.override
  ChatMemberRemovedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMemberRemovedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMemberRemovedProperties>(create);
  static ChatMemberRemovedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class ChatMemberRoleChangedProperties extends $pb.GeneratedMessage {
  factory ChatMemberRoleChangedProperties({
    $core.String? conversationId,
    $core.String? memberId,
    $core.String? previousRole,
    $core.String? newRole,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (memberId != null) result.memberId = memberId;
    if (previousRole != null) result.previousRole = previousRole;
    if (newRole != null) result.newRole = newRole;
    return result;
  }

  ChatMemberRoleChangedProperties._();

  factory ChatMemberRoleChangedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMemberRoleChangedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMemberRoleChangedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'previousRole')
    ..aOS(4, _omitFieldNames ? '' : 'newRole')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberRoleChangedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberRoleChangedProperties copyWith(
          void Function(ChatMemberRoleChangedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMemberRoleChangedProperties))
          as ChatMemberRoleChangedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMemberRoleChangedProperties create() =>
      ChatMemberRoleChangedProperties._();
  @$core.override
  ChatMemberRoleChangedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMemberRoleChangedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMemberRoleChangedProperties>(
          create);
  static ChatMemberRoleChangedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get previousRole => $_getSZ(2);
  @$pb.TagNumber(3)
  set previousRole($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPreviousRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreviousRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get newRole => $_getSZ(3);
  @$pb.TagNumber(4)
  set newRole($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewRole() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewRole() => $_clearField(4);
}

class ChatMessageSentProperties extends $pb.GeneratedMessage {
  factory ChatMessageSentProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? messageType,
    $core.int? characterCount,
    $core.int? attachmentCount,
    $core.String? threadId,
    $core.String? parentMessageId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (messageType != null) result.messageType = messageType;
    if (characterCount != null) result.characterCount = characterCount;
    if (attachmentCount != null) result.attachmentCount = attachmentCount;
    if (threadId != null) result.threadId = threadId;
    if (parentMessageId != null) result.parentMessageId = parentMessageId;
    return result;
  }

  ChatMessageSentProperties._();

  factory ChatMessageSentProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageSentProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageSentProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'messageType')
    ..aI(5, _omitFieldNames ? '' : 'characterCount')
    ..aI(6, _omitFieldNames ? '' : 'attachmentCount')
    ..aOS(7, _omitFieldNames ? '' : 'threadId')
    ..aOS(8, _omitFieldNames ? '' : 'parentMessageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageSentProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageSentProperties copyWith(
          void Function(ChatMessageSentProperties) updates) =>
      super.copyWith((message) => updates(message as ChatMessageSentProperties))
          as ChatMessageSentProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageSentProperties create() => ChatMessageSentProperties._();
  @$core.override
  ChatMessageSentProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageSentProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageSentProperties>(create);
  static ChatMessageSentProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get messageType => $_getSZ(3);
  @$pb.TagNumber(4)
  set messageType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessageType() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessageType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get characterCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set characterCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCharacterCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCharacterCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get attachmentCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set attachmentCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAttachmentCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAttachmentCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get threadId => $_getSZ(6);
  @$pb.TagNumber(7)
  set threadId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasThreadId() => $_has(6);
  @$pb.TagNumber(7)
  void clearThreadId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get parentMessageId => $_getSZ(7);
  @$pb.TagNumber(8)
  set parentMessageId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasParentMessageId() => $_has(7);
  @$pb.TagNumber(8)
  void clearParentMessageId() => $_clearField(8);
}

class ChatMessageReceivedProperties extends $pb.GeneratedMessage {
  factory ChatMessageReceivedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? messageType,
    $core.int? characterCount,
    $core.int? attachmentCount,
    $core.String? threadId,
    $core.String? parentMessageId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (messageType != null) result.messageType = messageType;
    if (characterCount != null) result.characterCount = characterCount;
    if (attachmentCount != null) result.attachmentCount = attachmentCount;
    if (threadId != null) result.threadId = threadId;
    if (parentMessageId != null) result.parentMessageId = parentMessageId;
    return result;
  }

  ChatMessageReceivedProperties._();

  factory ChatMessageReceivedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageReceivedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageReceivedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'messageType')
    ..aI(5, _omitFieldNames ? '' : 'characterCount')
    ..aI(6, _omitFieldNames ? '' : 'attachmentCount')
    ..aOS(7, _omitFieldNames ? '' : 'threadId')
    ..aOS(8, _omitFieldNames ? '' : 'parentMessageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageReceivedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageReceivedProperties copyWith(
          void Function(ChatMessageReceivedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessageReceivedProperties))
          as ChatMessageReceivedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageReceivedProperties create() =>
      ChatMessageReceivedProperties._();
  @$core.override
  ChatMessageReceivedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageReceivedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageReceivedProperties>(create);
  static ChatMessageReceivedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get messageType => $_getSZ(3);
  @$pb.TagNumber(4)
  set messageType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessageType() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessageType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get characterCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set characterCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCharacterCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCharacterCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get attachmentCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set attachmentCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAttachmentCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAttachmentCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get threadId => $_getSZ(6);
  @$pb.TagNumber(7)
  set threadId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasThreadId() => $_has(6);
  @$pb.TagNumber(7)
  void clearThreadId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get parentMessageId => $_getSZ(7);
  @$pb.TagNumber(8)
  set parentMessageId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasParentMessageId() => $_has(7);
  @$pb.TagNumber(8)
  void clearParentMessageId() => $_clearField(8);
}

class ChatMessageFailedProperties extends $pb.GeneratedMessage {
  factory ChatMessageFailedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? reason,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (reason != null) result.reason = reason;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatMessageFailedProperties._();

  factory ChatMessageFailedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageFailedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageFailedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..aOS(5, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageFailedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageFailedProperties copyWith(
          void Function(ChatMessageFailedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessageFailedProperties))
          as ChatMessageFailedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageFailedProperties create() =>
      ChatMessageFailedProperties._();
  @$core.override
  ChatMessageFailedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageFailedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageFailedProperties>(create);
  static ChatMessageFailedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get threadId => $_getSZ(4);
  @$pb.TagNumber(5)
  set threadId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasThreadId() => $_has(4);
  @$pb.TagNumber(5)
  void clearThreadId() => $_clearField(5);
}

class ChatMessageReadProperties extends $pb.GeneratedMessage {
  factory ChatMessageReadProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatMessageReadProperties._();

  factory ChatMessageReadProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageReadProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageReadProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageReadProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageReadProperties copyWith(
          void Function(ChatMessageReadProperties) updates) =>
      super.copyWith((message) => updates(message as ChatMessageReadProperties))
          as ChatMessageReadProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageReadProperties create() => ChatMessageReadProperties._();
  @$core.override
  ChatMessageReadProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageReadProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageReadProperties>(create);
  static ChatMessageReadProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get threadId => $_getSZ(3);
  @$pb.TagNumber(4)
  set threadId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreadId() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreadId() => $_clearField(4);
}

class ChatMessageDeletedProperties extends $pb.GeneratedMessage {
  factory ChatMessageDeletedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? reason,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (reason != null) result.reason = reason;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatMessageDeletedProperties._();

  factory ChatMessageDeletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageDeletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageDeletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..aOS(5, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageDeletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageDeletedProperties copyWith(
          void Function(ChatMessageDeletedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessageDeletedProperties))
          as ChatMessageDeletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageDeletedProperties create() =>
      ChatMessageDeletedProperties._();
  @$core.override
  ChatMessageDeletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageDeletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageDeletedProperties>(create);
  static ChatMessageDeletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get threadId => $_getSZ(4);
  @$pb.TagNumber(5)
  set threadId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasThreadId() => $_has(4);
  @$pb.TagNumber(5)
  void clearThreadId() => $_clearField(5);
}

class ChatMessageEditedProperties extends $pb.GeneratedMessage {
  factory ChatMessageEditedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatMessageEditedProperties._();

  factory ChatMessageEditedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageEditedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageEditedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageEditedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageEditedProperties copyWith(
          void Function(ChatMessageEditedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessageEditedProperties))
          as ChatMessageEditedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageEditedProperties create() =>
      ChatMessageEditedProperties._();
  @$core.override
  ChatMessageEditedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageEditedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageEditedProperties>(create);
  static ChatMessageEditedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get threadId => $_getSZ(3);
  @$pb.TagNumber(4)
  set threadId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreadId() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreadId() => $_clearField(4);
}

class ChatMessagePinnedProperties extends $pb.GeneratedMessage {
  factory ChatMessagePinnedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatMessagePinnedProperties._();

  factory ChatMessagePinnedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessagePinnedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessagePinnedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessagePinnedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessagePinnedProperties copyWith(
          void Function(ChatMessagePinnedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessagePinnedProperties))
          as ChatMessagePinnedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessagePinnedProperties create() =>
      ChatMessagePinnedProperties._();
  @$core.override
  ChatMessagePinnedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessagePinnedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessagePinnedProperties>(create);
  static ChatMessagePinnedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get threadId => $_getSZ(3);
  @$pb.TagNumber(4)
  set threadId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreadId() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreadId() => $_clearField(4);
}

class ChatMessageUnpinnedProperties extends $pb.GeneratedMessage {
  factory ChatMessageUnpinnedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? conversationType,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (conversationType != null) result.conversationType = conversationType;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatMessageUnpinnedProperties._();

  factory ChatMessageUnpinnedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessageUnpinnedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessageUnpinnedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'conversationType')
    ..aOS(4, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageUnpinnedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessageUnpinnedProperties copyWith(
          void Function(ChatMessageUnpinnedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessageUnpinnedProperties))
          as ChatMessageUnpinnedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessageUnpinnedProperties create() =>
      ChatMessageUnpinnedProperties._();
  @$core.override
  ChatMessageUnpinnedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessageUnpinnedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessageUnpinnedProperties>(create);
  static ChatMessageUnpinnedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationType => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConversationType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get threadId => $_getSZ(3);
  @$pb.TagNumber(4)
  set threadId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreadId() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreadId() => $_clearField(4);
}

class ChatTypingStartedProperties extends $pb.GeneratedMessage {
  factory ChatTypingStartedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    return result;
  }

  ChatTypingStartedProperties._();

  factory ChatTypingStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatTypingStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatTypingStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatTypingStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatTypingStartedProperties copyWith(
          void Function(ChatTypingStartedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatTypingStartedProperties))
          as ChatTypingStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatTypingStartedProperties create() =>
      ChatTypingStartedProperties._();
  @$core.override
  ChatTypingStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatTypingStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatTypingStartedProperties>(create);
  static ChatTypingStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);
}

class ChatTypingStoppedProperties extends $pb.GeneratedMessage {
  factory ChatTypingStoppedProperties({
    $core.String? conversationId,
    $core.String? conversationType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (conversationType != null) result.conversationType = conversationType;
    return result;
  }

  ChatTypingStoppedProperties._();

  factory ChatTypingStoppedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatTypingStoppedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatTypingStoppedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatTypingStoppedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatTypingStoppedProperties copyWith(
          void Function(ChatTypingStoppedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatTypingStoppedProperties))
          as ChatTypingStoppedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatTypingStoppedProperties create() =>
      ChatTypingStoppedProperties._();
  @$core.override
  ChatTypingStoppedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatTypingStoppedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatTypingStoppedProperties>(create);
  static ChatTypingStoppedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationType => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationType() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationType() => $_clearField(2);
}

class ChatAttachmentUploadedProperties extends $pb.GeneratedMessage {
  factory ChatAttachmentUploadedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? attachmentId,
    $core.String? attachmentType,
    $fixnum.Int64? sizeBytes,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (attachmentId != null) result.attachmentId = attachmentId;
    if (attachmentType != null) result.attachmentType = attachmentType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatAttachmentUploadedProperties._();

  factory ChatAttachmentUploadedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatAttachmentUploadedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatAttachmentUploadedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'attachmentId')
    ..aOS(4, _omitFieldNames ? '' : 'attachmentType')
    ..aInt64(5, _omitFieldNames ? '' : 'sizeBytes')
    ..aOS(6, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatAttachmentUploadedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatAttachmentUploadedProperties copyWith(
          void Function(ChatAttachmentUploadedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatAttachmentUploadedProperties))
          as ChatAttachmentUploadedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatAttachmentUploadedProperties create() =>
      ChatAttachmentUploadedProperties._();
  @$core.override
  ChatAttachmentUploadedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatAttachmentUploadedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatAttachmentUploadedProperties>(
          create);
  static ChatAttachmentUploadedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get attachmentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set attachmentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAttachmentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAttachmentId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get attachmentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set attachmentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAttachmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachmentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get sizeBytes => $_getI64(4);
  @$pb.TagNumber(5)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSizeBytes() => $_has(4);
  @$pb.TagNumber(5)
  void clearSizeBytes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get threadId => $_getSZ(5);
  @$pb.TagNumber(6)
  set threadId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasThreadId() => $_has(5);
  @$pb.TagNumber(6)
  void clearThreadId() => $_clearField(6);
}

class ChatAttachmentDownloadedProperties extends $pb.GeneratedMessage {
  factory ChatAttachmentDownloadedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? attachmentId,
    $core.String? attachmentType,
    $fixnum.Int64? sizeBytes,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (attachmentId != null) result.attachmentId = attachmentId;
    if (attachmentType != null) result.attachmentType = attachmentType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatAttachmentDownloadedProperties._();

  factory ChatAttachmentDownloadedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatAttachmentDownloadedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatAttachmentDownloadedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'attachmentId')
    ..aOS(4, _omitFieldNames ? '' : 'attachmentType')
    ..aInt64(5, _omitFieldNames ? '' : 'sizeBytes')
    ..aOS(6, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatAttachmentDownloadedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatAttachmentDownloadedProperties copyWith(
          void Function(ChatAttachmentDownloadedProperties) updates) =>
      super.copyWith((message) =>
              updates(message as ChatAttachmentDownloadedProperties))
          as ChatAttachmentDownloadedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatAttachmentDownloadedProperties create() =>
      ChatAttachmentDownloadedProperties._();
  @$core.override
  ChatAttachmentDownloadedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatAttachmentDownloadedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatAttachmentDownloadedProperties>(
          create);
  static ChatAttachmentDownloadedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get attachmentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set attachmentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAttachmentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAttachmentId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get attachmentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set attachmentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAttachmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachmentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get sizeBytes => $_getI64(4);
  @$pb.TagNumber(5)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSizeBytes() => $_has(4);
  @$pb.TagNumber(5)
  void clearSizeBytes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get threadId => $_getSZ(5);
  @$pb.TagNumber(6)
  set threadId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasThreadId() => $_has(5);
  @$pb.TagNumber(6)
  void clearThreadId() => $_clearField(6);
}

class ChatCallStartedProperties extends $pb.GeneratedMessage {
  factory ChatCallStartedProperties({
    $core.String? conversationId,
    $core.String? callId,
    $core.String? callType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (callId != null) result.callId = callId;
    if (callType != null) result.callType = callType;
    return result;
  }

  ChatCallStartedProperties._();

  factory ChatCallStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatCallStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCallStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'callId')
    ..aOS(3, _omitFieldNames ? '' : 'callType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallStartedProperties copyWith(
          void Function(ChatCallStartedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatCallStartedProperties))
          as ChatCallStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCallStartedProperties create() => ChatCallStartedProperties._();
  @$core.override
  ChatCallStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatCallStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatCallStartedProperties>(create);
  static ChatCallStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get callId => $_getSZ(1);
  @$pb.TagNumber(2)
  set callId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCallId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get callType => $_getSZ(2);
  @$pb.TagNumber(3)
  set callType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCallType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCallType() => $_clearField(3);
}

class ChatCallJoinedProperties extends $pb.GeneratedMessage {
  factory ChatCallJoinedProperties({
    $core.String? conversationId,
    $core.String? callId,
    $core.String? callType,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (callId != null) result.callId = callId;
    if (callType != null) result.callType = callType;
    return result;
  }

  ChatCallJoinedProperties._();

  factory ChatCallJoinedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatCallJoinedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCallJoinedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'callId')
    ..aOS(3, _omitFieldNames ? '' : 'callType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallJoinedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallJoinedProperties copyWith(
          void Function(ChatCallJoinedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatCallJoinedProperties))
          as ChatCallJoinedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCallJoinedProperties create() => ChatCallJoinedProperties._();
  @$core.override
  ChatCallJoinedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatCallJoinedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatCallJoinedProperties>(create);
  static ChatCallJoinedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get callId => $_getSZ(1);
  @$pb.TagNumber(2)
  set callId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCallId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get callType => $_getSZ(2);
  @$pb.TagNumber(3)
  set callType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCallType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCallType() => $_clearField(3);
}

class ChatCallLeftProperties extends $pb.GeneratedMessage {
  factory ChatCallLeftProperties({
    $core.String? conversationId,
    $core.String? callId,
    $core.String? callType,
    $0.Duration? duration,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (callId != null) result.callId = callId;
    if (callType != null) result.callType = callType;
    if (duration != null) result.duration = duration;
    return result;
  }

  ChatCallLeftProperties._();

  factory ChatCallLeftProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatCallLeftProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCallLeftProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'callId')
    ..aOS(3, _omitFieldNames ? '' : 'callType')
    ..aOM<$0.Duration>(4, _omitFieldNames ? '' : 'duration',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallLeftProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallLeftProperties copyWith(
          void Function(ChatCallLeftProperties) updates) =>
      super.copyWith((message) => updates(message as ChatCallLeftProperties))
          as ChatCallLeftProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCallLeftProperties create() => ChatCallLeftProperties._();
  @$core.override
  ChatCallLeftProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatCallLeftProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatCallLeftProperties>(create);
  static ChatCallLeftProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get callId => $_getSZ(1);
  @$pb.TagNumber(2)
  set callId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCallId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get callType => $_getSZ(2);
  @$pb.TagNumber(3)
  set callType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCallType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCallType() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Duration get duration => $_getN(3);
  @$pb.TagNumber(4)
  set duration($0.Duration value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuration() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Duration ensureDuration() => $_ensure(3);
}

class ChatCallScreenSharedProperties extends $pb.GeneratedMessage {
  factory ChatCallScreenSharedProperties({
    $core.String? conversationId,
    $core.String? callId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (callId != null) result.callId = callId;
    return result;
  }

  ChatCallScreenSharedProperties._();

  factory ChatCallScreenSharedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatCallScreenSharedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCallScreenSharedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'callId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallScreenSharedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallScreenSharedProperties copyWith(
          void Function(ChatCallScreenSharedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatCallScreenSharedProperties))
          as ChatCallScreenSharedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCallScreenSharedProperties create() =>
      ChatCallScreenSharedProperties._();
  @$core.override
  ChatCallScreenSharedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatCallScreenSharedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatCallScreenSharedProperties>(create);
  static ChatCallScreenSharedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get callId => $_getSZ(1);
  @$pb.TagNumber(2)
  set callId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCallId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallId() => $_clearField(2);
}

class ChatCallRecordingStartedProperties extends $pb.GeneratedMessage {
  factory ChatCallRecordingStartedProperties({
    $core.String? conversationId,
    $core.String? callId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (callId != null) result.callId = callId;
    return result;
  }

  ChatCallRecordingStartedProperties._();

  factory ChatCallRecordingStartedProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatCallRecordingStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCallRecordingStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'callId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallRecordingStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCallRecordingStartedProperties copyWith(
          void Function(ChatCallRecordingStartedProperties) updates) =>
      super.copyWith((message) =>
              updates(message as ChatCallRecordingStartedProperties))
          as ChatCallRecordingStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatCallRecordingStartedProperties create() =>
      ChatCallRecordingStartedProperties._();
  @$core.override
  ChatCallRecordingStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatCallRecordingStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatCallRecordingStartedProperties>(
          create);
  static ChatCallRecordingStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get callId => $_getSZ(1);
  @$pb.TagNumber(2)
  set callId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCallId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallId() => $_clearField(2);
}

/// mute_duration is optional — populate when the mute is time-bounded
/// (e.g. "mute for 1h"); leave unset for indefinite mutes.
class ChatMemberMutedProperties extends $pb.GeneratedMessage {
  factory ChatMemberMutedProperties({
    $core.String? conversationId,
    $core.String? memberId,
    $0.Duration? muteDuration,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (memberId != null) result.memberId = memberId;
    if (muteDuration != null) result.muteDuration = muteDuration;
    return result;
  }

  ChatMemberMutedProperties._();

  factory ChatMemberMutedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMemberMutedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMemberMutedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOM<$0.Duration>(3, _omitFieldNames ? '' : 'muteDuration',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberMutedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMemberMutedProperties copyWith(
          void Function(ChatMemberMutedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatMemberMutedProperties))
          as ChatMemberMutedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMemberMutedProperties create() => ChatMemberMutedProperties._();
  @$core.override
  ChatMemberMutedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMemberMutedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMemberMutedProperties>(create);
  static ChatMemberMutedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Duration get muteDuration => $_getN(2);
  @$pb.TagNumber(3)
  set muteDuration($0.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMuteDuration() => $_has(2);
  @$pb.TagNumber(3)
  void clearMuteDuration() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Duration ensureMuteDuration() => $_ensure(2);
}

/// User-level block (not conversation-scoped), so no conversation_id.
class ChatUserBlockedProperties extends $pb.GeneratedMessage {
  factory ChatUserBlockedProperties({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  ChatUserBlockedProperties._();

  factory ChatUserBlockedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatUserBlockedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatUserBlockedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatUserBlockedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatUserBlockedProperties copyWith(
          void Function(ChatUserBlockedProperties) updates) =>
      super.copyWith((message) => updates(message as ChatUserBlockedProperties))
          as ChatUserBlockedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatUserBlockedProperties create() => ChatUserBlockedProperties._();
  @$core.override
  ChatUserBlockedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatUserBlockedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatUserBlockedProperties>(create);
  static ChatUserBlockedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

/// `reaction` is the literal reaction value (emoji, shortcode, sticker id),
/// not a category. Compare reaction_type if a future schema needs to
/// distinguish emoji from sticker from gif reactions.
class ChatReactionAddedProperties extends $pb.GeneratedMessage {
  factory ChatReactionAddedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? reaction,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (reaction != null) result.reaction = reaction;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatReactionAddedProperties._();

  factory ChatReactionAddedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatReactionAddedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatReactionAddedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'reaction')
    ..aOS(4, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatReactionAddedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatReactionAddedProperties copyWith(
          void Function(ChatReactionAddedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatReactionAddedProperties))
          as ChatReactionAddedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatReactionAddedProperties create() =>
      ChatReactionAddedProperties._();
  @$core.override
  ChatReactionAddedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatReactionAddedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatReactionAddedProperties>(create);
  static ChatReactionAddedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reaction => $_getSZ(2);
  @$pb.TagNumber(3)
  set reaction($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearReaction() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get threadId => $_getSZ(3);
  @$pb.TagNumber(4)
  set threadId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreadId() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreadId() => $_clearField(4);
}

/// `reaction` is the literal reaction value (emoji, shortcode, sticker id),
/// not a category.
class ChatReactionRemovedProperties extends $pb.GeneratedMessage {
  factory ChatReactionRemovedProperties({
    $core.String? conversationId,
    $core.String? messageId,
    $core.String? reaction,
    $core.String? threadId,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (messageId != null) result.messageId = messageId;
    if (reaction != null) result.reaction = reaction;
    if (threadId != null) result.threadId = threadId;
    return result;
  }

  ChatReactionRemovedProperties._();

  factory ChatReactionRemovedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatReactionRemovedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatReactionRemovedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'reaction')
    ..aOS(4, _omitFieldNames ? '' : 'threadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatReactionRemovedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatReactionRemovedProperties copyWith(
          void Function(ChatReactionRemovedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as ChatReactionRemovedProperties))
          as ChatReactionRemovedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatReactionRemovedProperties create() =>
      ChatReactionRemovedProperties._();
  @$core.override
  ChatReactionRemovedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatReactionRemovedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatReactionRemovedProperties>(create);
  static ChatReactionRemovedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reaction => $_getSZ(2);
  @$pb.TagNumber(3)
  set reaction($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearReaction() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get threadId => $_getSZ(3);
  @$pb.TagNumber(4)
  set threadId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThreadId() => $_has(3);
  @$pb.TagNumber(4)
  void clearThreadId() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
