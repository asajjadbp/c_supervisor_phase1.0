import 'dart:io';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';
import '../../data/models/index.dart';

class UploadImageCubit extends BaseAppCubit<ImageResponseModel?> {
  UploadImageCubit({required this.uploadImageUC});

  final UploadImageUC uploadImageUC;

  Future<BaseResponse<ImageResponseModel?>> uploadImages({
    required List<File> files,
  }) async {
    return await networkCall(
      () => uploadImageUC.uploadImages(files),
    );
  }
}
