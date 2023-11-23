import 'dart:io';
import 'package:c_supervisor/utilities/file_helper.dart';
import 'package:flutter_core/tools/index.dart';

mixin FilesNameCreatorMixin {
  createFileName(XFile image, {int visitId = 0, String moduleName = ""}) async {
    File tempImage = File(image.path);
    String path = "";
    String extension = "";

    /// Get the actual file extension from the file path
    extension = tempImage.path.split('.').last;

    /// Generate the filename with the actual file extension
    path = await FileHelper.changeFileNameOnly(
        tempImage,
        "${DateTime.now().millisecondsSinceEpoch.toString()}-$visitId-$moduleName.$extension")
        .then((value) => value.path);

    return path;
  }
}
