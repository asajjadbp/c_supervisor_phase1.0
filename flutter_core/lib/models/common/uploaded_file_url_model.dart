/// UploadedFileUrlModel hold currently uploaded files
class UploadedFileUrlModel {
  UploadedFileUrlModel({
    required this.fileName,
    required this.fileUrl,
  });

  String fileName;
  String fileUrl;

  factory UploadedFileUrlModel.fromJson(Map<String, dynamic> json) =>
      UploadedFileUrlModel(
        fileName: json["fileName"],
        fileUrl: json["fileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileUrl": fileUrl,
      };
}
