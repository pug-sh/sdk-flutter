// This is a generated file - do not edit.
//
// Generated from common/events/v1/media_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class VideoStartedProperties extends $pb.GeneratedMessage {
  factory VideoStartedProperties({
    $core.String? videoId,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    return result;
  }

  VideoStartedProperties._();

  factory VideoStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoStartedProperties copyWith(
          void Function(VideoStartedProperties) updates) =>
      super.copyWith((message) => updates(message as VideoStartedProperties))
          as VideoStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoStartedProperties create() => VideoStartedProperties._();
  @$core.override
  VideoStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoStartedProperties>(create);
  static VideoStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);
}

class VideoPlayProperties extends $pb.GeneratedMessage {
  factory VideoPlayProperties({
    $core.String? videoId,
    $0.Duration? position,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    if (position != null) result.position = position;
    return result;
  }

  VideoPlayProperties._();

  factory VideoPlayProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoPlayProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoPlayProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aOM<$0.Duration>(2, _omitFieldNames ? '' : 'position',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPlayProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPlayProperties copyWith(void Function(VideoPlayProperties) updates) =>
      super.copyWith((message) => updates(message as VideoPlayProperties))
          as VideoPlayProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoPlayProperties create() => VideoPlayProperties._();
  @$core.override
  VideoPlayProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoPlayProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoPlayProperties>(create);
  static VideoPlayProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Duration get position => $_getN(1);
  @$pb.TagNumber(2)
  set position($0.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Duration ensurePosition() => $_ensure(1);
}

class VideoPauseProperties extends $pb.GeneratedMessage {
  factory VideoPauseProperties({
    $core.String? videoId,
    $0.Duration? position,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    if (position != null) result.position = position;
    return result;
  }

  VideoPauseProperties._();

  factory VideoPauseProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoPauseProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoPauseProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aOM<$0.Duration>(2, _omitFieldNames ? '' : 'position',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPauseProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoPauseProperties copyWith(void Function(VideoPauseProperties) updates) =>
      super.copyWith((message) => updates(message as VideoPauseProperties))
          as VideoPauseProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoPauseProperties create() => VideoPauseProperties._();
  @$core.override
  VideoPauseProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoPauseProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoPauseProperties>(create);
  static VideoPauseProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Duration get position => $_getN(1);
  @$pb.TagNumber(2)
  set position($0.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Duration ensurePosition() => $_ensure(1);
}

class VideoSeekedProperties extends $pb.GeneratedMessage {
  factory VideoSeekedProperties({
    $core.String? videoId,
    $0.Duration? fromPosition,
    $0.Duration? toPosition,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    if (fromPosition != null) result.fromPosition = fromPosition;
    if (toPosition != null) result.toPosition = toPosition;
    return result;
  }

  VideoSeekedProperties._();

  factory VideoSeekedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoSeekedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoSeekedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aOM<$0.Duration>(2, _omitFieldNames ? '' : 'fromPosition',
        subBuilder: $0.Duration.create)
    ..aOM<$0.Duration>(3, _omitFieldNames ? '' : 'toPosition',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoSeekedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoSeekedProperties copyWith(
          void Function(VideoSeekedProperties) updates) =>
      super.copyWith((message) => updates(message as VideoSeekedProperties))
          as VideoSeekedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoSeekedProperties create() => VideoSeekedProperties._();
  @$core.override
  VideoSeekedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoSeekedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoSeekedProperties>(create);
  static VideoSeekedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Duration get fromPosition => $_getN(1);
  @$pb.TagNumber(2)
  set fromPosition($0.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFromPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Duration ensureFromPosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.Duration get toPosition => $_getN(2);
  @$pb.TagNumber(3)
  set toPosition($0.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasToPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearToPosition() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Duration ensureToPosition() => $_ensure(2);
}

class VideoCompletedProperties extends $pb.GeneratedMessage {
  factory VideoCompletedProperties({
    $core.String? videoId,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    return result;
  }

  VideoCompletedProperties._();

  factory VideoCompletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoCompletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoCompletedProperties copyWith(
          void Function(VideoCompletedProperties) updates) =>
      super.copyWith((message) => updates(message as VideoCompletedProperties))
          as VideoCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoCompletedProperties create() => VideoCompletedProperties._();
  @$core.override
  VideoCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoCompletedProperties>(create);
  static VideoCompletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);
}

class AudioStartedProperties extends $pb.GeneratedMessage {
  factory AudioStartedProperties({
    $core.String? audioId,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
    return result;
  }

  AudioStartedProperties._();

  factory AudioStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioStartedProperties copyWith(
          void Function(AudioStartedProperties) updates) =>
      super.copyWith((message) => updates(message as AudioStartedProperties))
          as AudioStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioStartedProperties create() => AudioStartedProperties._();
  @$core.override
  AudioStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioStartedProperties>(create);
  static AudioStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);
}

class AudioPlayProperties extends $pb.GeneratedMessage {
  factory AudioPlayProperties({
    $core.String? audioId,
    $0.Duration? position,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
    if (position != null) result.position = position;
    return result;
  }

  AudioPlayProperties._();

  factory AudioPlayProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioPlayProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioPlayProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
    ..aOM<$0.Duration>(2, _omitFieldNames ? '' : 'position',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioPlayProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioPlayProperties copyWith(void Function(AudioPlayProperties) updates) =>
      super.copyWith((message) => updates(message as AudioPlayProperties))
          as AudioPlayProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioPlayProperties create() => AudioPlayProperties._();
  @$core.override
  AudioPlayProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioPlayProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioPlayProperties>(create);
  static AudioPlayProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Duration get position => $_getN(1);
  @$pb.TagNumber(2)
  set position($0.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Duration ensurePosition() => $_ensure(1);
}

class AudioPauseProperties extends $pb.GeneratedMessage {
  factory AudioPauseProperties({
    $core.String? audioId,
    $0.Duration? position,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
    if (position != null) result.position = position;
    return result;
  }

  AudioPauseProperties._();

  factory AudioPauseProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioPauseProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioPauseProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
    ..aOM<$0.Duration>(2, _omitFieldNames ? '' : 'position',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioPauseProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioPauseProperties copyWith(void Function(AudioPauseProperties) updates) =>
      super.copyWith((message) => updates(message as AudioPauseProperties))
          as AudioPauseProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioPauseProperties create() => AudioPauseProperties._();
  @$core.override
  AudioPauseProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioPauseProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioPauseProperties>(create);
  static AudioPauseProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Duration get position => $_getN(1);
  @$pb.TagNumber(2)
  set position($0.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Duration ensurePosition() => $_ensure(1);
}

class AudioSeekedProperties extends $pb.GeneratedMessage {
  factory AudioSeekedProperties({
    $core.String? audioId,
    $0.Duration? fromPosition,
    $0.Duration? toPosition,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
    if (fromPosition != null) result.fromPosition = fromPosition;
    if (toPosition != null) result.toPosition = toPosition;
    return result;
  }

  AudioSeekedProperties._();

  factory AudioSeekedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioSeekedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioSeekedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
    ..aOM<$0.Duration>(2, _omitFieldNames ? '' : 'fromPosition',
        subBuilder: $0.Duration.create)
    ..aOM<$0.Duration>(3, _omitFieldNames ? '' : 'toPosition',
        subBuilder: $0.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioSeekedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioSeekedProperties copyWith(
          void Function(AudioSeekedProperties) updates) =>
      super.copyWith((message) => updates(message as AudioSeekedProperties))
          as AudioSeekedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioSeekedProperties create() => AudioSeekedProperties._();
  @$core.override
  AudioSeekedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioSeekedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioSeekedProperties>(create);
  static AudioSeekedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Duration get fromPosition => $_getN(1);
  @$pb.TagNumber(2)
  set fromPosition($0.Duration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFromPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Duration ensureFromPosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.Duration get toPosition => $_getN(2);
  @$pb.TagNumber(3)
  set toPosition($0.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasToPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearToPosition() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Duration ensureToPosition() => $_ensure(2);
}

class AudioCompletedProperties extends $pb.GeneratedMessage {
  factory AudioCompletedProperties({
    $core.String? audioId,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
    return result;
  }

  AudioCompletedProperties._();

  factory AudioCompletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioCompletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioCompletedProperties copyWith(
          void Function(AudioCompletedProperties) updates) =>
      super.copyWith((message) => updates(message as AudioCompletedProperties))
          as AudioCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioCompletedProperties create() => AudioCompletedProperties._();
  @$core.override
  AudioCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioCompletedProperties>(create);
  static AudioCompletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
