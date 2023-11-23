import 'dart:convert';

/// hold File setting in the whole app
FileSettingModel fileSettingModelFromJson(String str) =>
    FileSettingModel.fromJson(json.decode(str));

String fileSettingModelToJson(FileSettingModel data) =>
    json.encode(data.toJson());

class FileSettingModel {
  FileSettingModel({
    required this.uploadButtonMaxFileSizeInMb,
    required this.uploadButtonMaxFilesCount,
    required this.maxAllowedFileSizeInMBErrorMessage,
    required this.maxAllowedFileCountErrorMessage,
    required this.fileNotSupportedErrorMessage,
  });

  /// Indicates number of max MB per file allowed per upload file form field
  int uploadButtonMaxFileSizeInMb;

  /// Indicates number of max files count allowed per upload file form field
  int uploadButtonMaxFilesCount;

  String? maxAllowedFileCountErrorMessage,
      maxAllowedFileSizeInMBErrorMessage,
      fileNotSupportedErrorMessage;

  static FileSettingModel defaultFileSetting({
    required String fileSizeExceedLimitMBErrorMessage,
    required String fileCountExceedLimitErrorMessage,
    required String fileNotSupportedErrorMessage,
  }) =>
      FileSettingModel(
          uploadButtonMaxFileSizeInMb: defaultMaxFileCountLimit,
          uploadButtonMaxFilesCount: defaultMaxFileSizeLimit,
          maxAllowedFileCountErrorMessage: fileCountExceedLimitErrorMessage,
          maxAllowedFileSizeInMBErrorMessage: fileSizeExceedLimitMBErrorMessage,
          fileNotSupportedErrorMessage: fileNotSupportedErrorMessage);

  static int get defaultMaxFileCountLimit => 3;

  static int get defaultMaxFileSizeLimit => 8;

  factory FileSettingModel.fromJson(Map<String, dynamic> json) =>
      FileSettingModel(
        uploadButtonMaxFileSizeInMb: json["uploadButtonMaxFileSizeInMB"],
        uploadButtonMaxFilesCount: json["uploadButtonMaxFilesCount"],
        maxAllowedFileCountErrorMessage:
            json["uploadButtonMaxFilesCountErrorMessage"],
        maxAllowedFileSizeInMBErrorMessage:
            json['uploadButtonMaxFileSizeInMBErrorMessage'],
        fileNotSupportedErrorMessage: json['fileNotSupportedErrorMessage'],
      );

  Map<String, dynamic> toJson() => {
        "uploadButtonMaxFileSizeInMB": uploadButtonMaxFileSizeInMb,
        "uploadButtonMaxFilesCount": uploadButtonMaxFilesCount,
        "uploadButtonMaxFilesCountErrorMessage":
            maxAllowedFileCountErrorMessage,
        "uploadButtonMaxFileSizeInMBErrorMessage":
            maxAllowedFileSizeInMBErrorMessage,
        "fileNotSupportedErrorMessage": fileNotSupportedErrorMessage,
      };
}
