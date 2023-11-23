import 'dart:io';

import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
import '../models/index.dart';

class UploadImageRepoImp implements UploadImageRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  UploadImageRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<ImageResponseModel?>> uploadImages(
      List<File> files) async {
    return applicationRemoteDS.uploadImages(files);
  }
}
