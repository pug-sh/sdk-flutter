// This is a generated file - do not edit.
//
// Generated from common/events/v1/file_events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FileUploadedProperties extends $pb.GeneratedMessage {
  factory FileUploadedProperties({
    $core.String? fileId,
    $core.String? fileName,
    $core.String? fileType,
    $fixnum.Int64? sizeBytes,
  }) {
    final result = create();
    if (fileId != null) result.fileId = fileId;
    if (fileName != null) result.fileName = fileName;
    if (fileType != null) result.fileType = fileType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    return result;
  }

  FileUploadedProperties._();

  factory FileUploadedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileUploadedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileUploadedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileId')
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..aOS(3, _omitFieldNames ? '' : 'fileType')
    ..aInt64(4, _omitFieldNames ? '' : 'sizeBytes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileUploadedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileUploadedProperties copyWith(
          void Function(FileUploadedProperties) updates) =>
      super.copyWith((message) => updates(message as FileUploadedProperties))
          as FileUploadedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileUploadedProperties create() => FileUploadedProperties._();
  @$core.override
  FileUploadedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FileUploadedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileUploadedProperties>(create);
  static FileUploadedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileType => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileType() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sizeBytes => $_getI64(3);
  @$pb.TagNumber(4)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSizeBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearSizeBytes() => $_clearField(4);
}

class FileDownloadedProperties extends $pb.GeneratedMessage {
  factory FileDownloadedProperties({
    $core.String? fileId,
    $core.String? fileName,
    $core.String? fileType,
    $fixnum.Int64? sizeBytes,
  }) {
    final result = create();
    if (fileId != null) result.fileId = fileId;
    if (fileName != null) result.fileName = fileName;
    if (fileType != null) result.fileType = fileType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    return result;
  }

  FileDownloadedProperties._();

  factory FileDownloadedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileDownloadedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileDownloadedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileId')
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..aOS(3, _omitFieldNames ? '' : 'fileType')
    ..aInt64(4, _omitFieldNames ? '' : 'sizeBytes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileDownloadedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileDownloadedProperties copyWith(
          void Function(FileDownloadedProperties) updates) =>
      super.copyWith((message) => updates(message as FileDownloadedProperties))
          as FileDownloadedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileDownloadedProperties create() => FileDownloadedProperties._();
  @$core.override
  FileDownloadedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FileDownloadedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileDownloadedProperties>(create);
  static FileDownloadedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileType => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileType() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sizeBytes => $_getI64(3);
  @$pb.TagNumber(4)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSizeBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearSizeBytes() => $_clearField(4);
}

class ExportStartedProperties extends $pb.GeneratedMessage {
  factory ExportStartedProperties({
    $core.String? exportId,
    $core.String? exportType,
  }) {
    final result = create();
    if (exportId != null) result.exportId = exportId;
    if (exportType != null) result.exportType = exportType;
    return result;
  }

  ExportStartedProperties._();

  factory ExportStartedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExportStartedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportStartedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'exportId')
    ..aOS(2, _omitFieldNames ? '' : 'exportType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportStartedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportStartedProperties copyWith(
          void Function(ExportStartedProperties) updates) =>
      super.copyWith((message) => updates(message as ExportStartedProperties))
          as ExportStartedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportStartedProperties create() => ExportStartedProperties._();
  @$core.override
  ExportStartedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExportStartedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportStartedProperties>(create);
  static ExportStartedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get exportId => $_getSZ(0);
  @$pb.TagNumber(1)
  set exportId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExportId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExportId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get exportType => $_getSZ(1);
  @$pb.TagNumber(2)
  set exportType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExportType() => $_has(1);
  @$pb.TagNumber(2)
  void clearExportType() => $_clearField(2);
}

class ExportCompletedProperties extends $pb.GeneratedMessage {
  factory ExportCompletedProperties({
    $core.String? exportId,
    $core.String? exportType,
    $fixnum.Int64? sizeBytes,
  }) {
    final result = create();
    if (exportId != null) result.exportId = exportId;
    if (exportType != null) result.exportType = exportType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    return result;
  }

  ExportCompletedProperties._();

  factory ExportCompletedProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExportCompletedProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExportCompletedProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'common.events.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'exportId')
    ..aOS(2, _omitFieldNames ? '' : 'exportType')
    ..aInt64(3, _omitFieldNames ? '' : 'sizeBytes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportCompletedProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExportCompletedProperties copyWith(
          void Function(ExportCompletedProperties) updates) =>
      super.copyWith((message) => updates(message as ExportCompletedProperties))
          as ExportCompletedProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportCompletedProperties create() => ExportCompletedProperties._();
  @$core.override
  ExportCompletedProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExportCompletedProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExportCompletedProperties>(create);
  static ExportCompletedProperties? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get exportId => $_getSZ(0);
  @$pb.TagNumber(1)
  set exportId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExportId() => $_has(0);
  @$pb.TagNumber(1)
  void clearExportId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get exportType => $_getSZ(1);
  @$pb.TagNumber(2)
  set exportType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExportType() => $_has(1);
  @$pb.TagNumber(2)
  void clearExportType() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get sizeBytes => $_getI64(2);
  @$pb.TagNumber(3)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSizeBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearSizeBytes() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
