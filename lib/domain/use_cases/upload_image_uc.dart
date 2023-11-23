import 'dart:io';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class UploadImageUC {
  final UploadImageRepo uploadImageRepo;

  UploadImageUC(this.uploadImageRepo);

  Future<BaseResponse<ImageResponseModel?>> uploadImages(
      List<File> files) async {
    return await uploadImageRepo.uploadImages(files);
  }
}
