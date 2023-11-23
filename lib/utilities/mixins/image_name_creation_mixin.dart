import 'dart:io';
import 'package:c_supervisor/utilities/file_helper.dart';
import 'package:flutter_core/tools/index.dart';

mixin ImageNameCreatorMixin {
  createPhotoName(XFile image,
      {int visitId = 0, String moduleName = ""}) async {
    File tempImage = File(image.path);
    String path = "";
    path = await FileHelper.changeFileNameOnly(tempImage,
            "${DateTime.now().millisecondsSinceEpoch.toString()}-$visitId-$moduleName.jpg")
        .then((value) => value.path);

    return path;
  }

  createPhotoNameSOS(XFile image,
      {int visitId = 187169, String moduleName = ""}) async {
    File tempImage = File(image.path);
    String path = "";
    path = await FileHelper.changeFileNameOnly(tempImage,
            "${DateTime.now().millisecondsSinceEpoch.toString()}-$visitId-$moduleName.jpg")
        .then((value) => value.path);

    return path;
  }

  createPhotoNameMyJP(XFile image,
      {required int visitId, String moduleName = ""}) async {
    File tempImage = File(image.path);
    String path = "";
    path = await FileHelper.changeFileNameOnly(tempImage,
            "${DateTime.now().millisecondsSinceEpoch.toString()}-$visitId-$moduleName.jpg")
        .then((value) => value.path);

    return path;
  }
}
