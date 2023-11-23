import 'dart:io';

import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class UploadImageRepo {
  Future<BaseResponse<ImageResponseModel?>> uploadImages(List<File> files);
}
