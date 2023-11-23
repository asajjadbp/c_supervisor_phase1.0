import 'package:c_supervisor/ui/index.dart';

class AddFileModel implements BaseNetworkDeserializable {
  int? categoryId;
  String? filePath;
  String? fileName;
  String? fileDesc;
  int? userId;

  AddFileModel({
    this.categoryId,
    this.filePath,
    this.fileName,
    this.fileDesc,
    this.userId,
    this.message,
    this.code,
  });
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['filePath'] = filePath;
    map['fileName'] = fileName;
    map['fileDesc'] = fileDesc;
    map['userId'] = userId;

    return map;
  }

  String? message;
  int? code;

  @override
  AddFileModel fromJson(Map<String, dynamic> json) => AddFileModel(
        message: json['message'],
        code: json['code'],
      );
}
