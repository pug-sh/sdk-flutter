// This is a generated file - do not edit.
//
// Generated from common/events/v1/support_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FeedbackSubmittedProperties extends $pb.GeneratedMessage {
  factory FeedbackSubmittedProperties({
    $core.String? feedbackId,
    $core.String? category,
    $core.String? comment,
  }) {
    final result = create();
    if (feedbackId != null) result.feedbackId = feedbackId;
    if (category != null) result.category = category;
    if (comment != null) result.comment = comment;
    return result;
  }

  FeedbackSubmittedProperties._();

  factory FeedbackSubmittedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeedbackSubmittedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeedbackSubmittedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'feedbackId')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..aOS(3, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedbackSubmittedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedbackSubmittedProperties copyWith(
          void Function(FeedbackSubmittedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as FeedbackSubmittedProperties))
          as FeedbackSubmittedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedbackSubmittedProperties create() =>
      FeedbackSubmittedProperties._();
  @$core.override
  FeedbackSubmittedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FeedbackSubmittedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeedbackSubmittedProperties>(create);
  static FeedbackSubmittedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get feedbackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set feedbackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFeedbackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeedbackId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get comment => $_getSZ(2);
  @$pb.TagNumber(3)
  set comment($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasComment() => $_has(2);
  @$pb.TagNumber(3)
  void clearComment() => $_clearField(3);
}

class NpsSubmittedProperties extends $pb.GeneratedMessage {
  factory NpsSubmittedProperties({
    $core.int? score,
    $core.String? comment,
  }) {
    final result = create();
    if (score != null) result.score = score;
    if (comment != null) result.comment = comment;
    return result;
  }

  NpsSubmittedProperties._();

  factory NpsSubmittedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NpsSubmittedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NpsSubmittedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'score')
    ..aOS(2, _omitFieldNames ? '' : 'comment')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NpsSubmittedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NpsSubmittedProperties copyWith(
          void Function(NpsSubmittedProperties) updates) =>
      super.copyWith((message) => updates(message as NpsSubmittedProperties))
          as NpsSubmittedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NpsSubmittedProperties create() => NpsSubmittedProperties._();
  @$core.override
  NpsSubmittedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NpsSubmittedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NpsSubmittedProperties>(create);
  static NpsSubmittedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get score => $_getIZ(0);
  @$pb.TagNumber(1)
  set score($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get comment => $_getSZ(1);
  @$pb.TagNumber(2)
  set comment($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasComment() => $_has(1);
  @$pb.TagNumber(2)
  void clearComment() => $_clearField(2);
}

class SurveyStartedProperties extends $pb.GeneratedMessage {
  factory SurveyStartedProperties({
    $core.String? surveyId,
  }) {
    final result = create();
    if (surveyId != null) result.surveyId = surveyId;
    return result;
  }

  SurveyStartedProperties._();

  factory SurveyStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SurveyStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SurveyStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'surveyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SurveyStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SurveyStartedProperties copyWith(
          void Function(SurveyStartedProperties) updates) =>
      super.copyWith((message) => updates(message as SurveyStartedProperties))
          as SurveyStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SurveyStartedProperties create() => SurveyStartedProperties._();
  @$core.override
  SurveyStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SurveyStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SurveyStartedProperties>(create);
  static SurveyStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get surveyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set surveyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSurveyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSurveyId() => $_clearField(1);
}

class SurveyCompletedProperties extends $pb.GeneratedMessage {
  factory SurveyCompletedProperties({
    $core.String? surveyId,
    $core.int? questionCount,
  }) {
    final result = create();
    if (surveyId != null) result.surveyId = surveyId;
    if (questionCount != null) result.questionCount = questionCount;
    return result;
  }

  SurveyCompletedProperties._();

  factory SurveyCompletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SurveyCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SurveyCompletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'surveyId')
    ..aI(2, _omitFieldNames ? '' : 'questionCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SurveyCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SurveyCompletedProperties copyWith(
          void Function(SurveyCompletedProperties) updates) =>
      super.copyWith((message) => updates(message as SurveyCompletedProperties))
          as SurveyCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SurveyCompletedProperties create() => SurveyCompletedProperties._();
  @$core.override
  SurveyCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SurveyCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SurveyCompletedProperties>(create);
  static SurveyCompletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get surveyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set surveyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSurveyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSurveyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get questionCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set questionCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuestionCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuestionCount() => $_clearField(2);
}

class SupportTicketCreatedProperties extends $pb.GeneratedMessage {
  factory SupportTicketCreatedProperties({
    $core.String? ticketId,
    $core.String? category,
    $core.String? priority,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (category != null) result.category = category;
    if (priority != null) result.priority = priority;
    return result;
  }

  SupportTicketCreatedProperties._();

  factory SupportTicketCreatedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportTicketCreatedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportTicketCreatedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..aOS(3, _omitFieldNames ? '' : 'priority')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportTicketCreatedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportTicketCreatedProperties copyWith(
          void Function(SupportTicketCreatedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SupportTicketCreatedProperties))
          as SupportTicketCreatedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportTicketCreatedProperties create() =>
      SupportTicketCreatedProperties._();
  @$core.override
  SupportTicketCreatedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SupportTicketCreatedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportTicketCreatedProperties>(create);
  static SupportTicketCreatedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get priority => $_getSZ(2);
  @$pb.TagNumber(3)
  set priority($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPriority() => $_has(2);
  @$pb.TagNumber(3)
  void clearPriority() => $_clearField(3);
}

class SupportTicketResolvedProperties extends $pb.GeneratedMessage {
  factory SupportTicketResolvedProperties({
    $core.String? ticketId,
    $core.String? resolution,
  }) {
    final result = create();
    if (ticketId != null) result.ticketId = ticketId;
    if (resolution != null) result.resolution = resolution;
    return result;
  }

  SupportTicketResolvedProperties._();

  factory SupportTicketResolvedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportTicketResolvedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportTicketResolvedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ticketId')
    ..aOS(2, _omitFieldNames ? '' : 'resolution')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportTicketResolvedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportTicketResolvedProperties copyWith(
          void Function(SupportTicketResolvedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SupportTicketResolvedProperties))
          as SupportTicketResolvedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportTicketResolvedProperties create() =>
      SupportTicketResolvedProperties._();
  @$core.override
  SupportTicketResolvedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SupportTicketResolvedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportTicketResolvedProperties>(
          create);
  static SupportTicketResolvedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ticketId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ticketId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTicketId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicketId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolution => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolution($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolution() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolution() => $_clearField(2);
}

class SupportChatStartedProperties extends $pb.GeneratedMessage {
  factory SupportChatStartedProperties({
    $core.String? conversationId,
    $core.String? topic,
  }) {
    final result = create();
    if (conversationId != null) result.conversationId = conversationId;
    if (topic != null) result.topic = topic;
    return result;
  }

  SupportChatStartedProperties._();

  factory SupportChatStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupportChatStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupportChatStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'conversationId')
    ..aOS(2, _omitFieldNames ? '' : 'topic')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportChatStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupportChatStartedProperties copyWith(
          void Function(SupportChatStartedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as SupportChatStartedProperties))
          as SupportChatStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupportChatStartedProperties create() =>
      SupportChatStartedProperties._();
  @$core.override
  SupportChatStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SupportChatStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupportChatStartedProperties>(create);
  static SupportChatStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get topic => $_getSZ(1);
  @$pb.TagNumber(2)
  set topic($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTopic() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopic() => $_clearField(2);
}

class HelpArticleViewedProperties extends $pb.GeneratedMessage {
  factory HelpArticleViewedProperties({
    $core.String? articleId,
    $core.String? articleTitle,
    $core.String? category,
  }) {
    final result = create();
    if (articleId != null) result.articleId = articleId;
    if (articleTitle != null) result.articleTitle = articleTitle;
    if (category != null) result.category = category;
    return result;
  }

  HelpArticleViewedProperties._();

  factory HelpArticleViewedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HelpArticleViewedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HelpArticleViewedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'articleId')
    ..aOS(2, _omitFieldNames ? '' : 'articleTitle')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HelpArticleViewedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HelpArticleViewedProperties copyWith(
          void Function(HelpArticleViewedProperties) updates) =>
      super.copyWith(
              (message) => updates(message as HelpArticleViewedProperties))
          as HelpArticleViewedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HelpArticleViewedProperties create() =>
      HelpArticleViewedProperties._();
  @$core.override
  HelpArticleViewedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HelpArticleViewedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HelpArticleViewedProperties>(create);
  static HelpArticleViewedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get articleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set articleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasArticleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearArticleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get articleTitle => $_getSZ(1);
  @$pb.TagNumber(2)
  set articleTitle($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasArticleTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearArticleTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
