import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:path/path.dart' as p;

export 'package:image_picker/image_picker.dart';

export 'picker_action/camera_picker_action.dart';
export 'picker_action/exceptions/file_picker_exceptions.dart';
export 'picker_action/files_picker_action.dart';
export 'picker_action/gallery_picker_action.dart';
export 'picker_action/picker_action.dart';
export 'picker_action/picker_properties.dart';

/// An object that handles selecting files or images
class FileImagePicker {
  /// Handles selecting files file managers
  ///
  /// [maxAllowedFileCount] is the maximum allowed files to be picked
  /// [allowedExtensions] optional list of string specifying the allowed extensions
  /// if [allowedExtensions] is provided [filetype] is set to [FileType.custom]
  ///
  /// example: `await pickFile(maxAllowedFileCount: 1, filesTypes: ["pdf", "svg"])
  Future<List<XFile>> pickFile({
    required PickerProperties properties,
    int maxAllowedFileCount = 1,
    List<String>? allowedExtensions,
  }) async {
    /// TODO(refactor): use [allowMultiple] to enable max allowed file
    final allowMultiple = maxAllowedFileCount > 1;
    final fileTypes =
        allowedExtensions == null ? FileType.any : FileType.custom;
    FilePickerResult? pickerResult = await FilePicker.platform.pickFiles(

        /// Use [allowMultiple] with 'false' value to prevent user from select multiple files
        allowMultiple: false,
        allowedExtensions: allowedExtensions,
        type: fileTypes);

    if (pickerResult != null && pickerResult.paths.isNotEmpty) {
      if (pickerResult.validateSelectedPaths(allowedExtensions ?? [])) {
        final result = pickerResult.paths
            .compactMap((path) => (path != null) ? XFile(path) : null);
        return result;
      } else {
        /// throw exception in case selected files not supported
        throw FilePickerException.fileNotSupportedTypeException(
          properties.fileNotSupportedErrorMessage ?? "",
        );
      }
    } else {
      return [];
    }
  }

  /// Handles picking an image from the gallery
  ///
  /// [imageQuality] denotes the compression value of the image
  /// value ranges from 1 - 100; the more it is the higher the quality and the image size
  /// as the value goes down the image becomes compressed
  Future<List<XFile>> pickImageFromGallery(int imageQuality) async {
    final ImagePicker _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );

    // pickedImage might be null so we map the list with compact map to eliminate nulls
    // try replacing with `?? []` to further understand (e.g.: `[pickedImage] ?? []` )
    return [pickedImage].whereNotNull().toList();
  }

  /// Handles picking multiple images from the gallery
  ///
  /// [imageQuality] denotes the compression value of the image
  /// value ranges from 1 - 100; the more it is the higher the quality and the image size
  /// as the value goes down the image becomes compressed
  Future<List<XFile>> pickMultipleImagesFromGallery(int imageQuality) async {
    final ImagePicker _picker = ImagePicker();
    final selectedFiles =
        await _picker.pickMultiImage(imageQuality: imageQuality);

    // selectedFiles is a nullable list so null might be return
    // in such case we return an empty list
    return selectedFiles ?? [];
  }

  /// Handles selecting image from the camera
  ///
  /// [imageQuality] denotes the compression value of the image
  /// value ranges from 1 - 100; the more it is the higher the quality and the image size
  /// as the value goes down the image becomes compressed
  Future<List<XFile>> captureImage(int imageQuality) async {
    final ImagePicker _picker = ImagePicker();
    final capturedImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );

    //convert the image of type XFile to list of XFile to match the return type of other methods in this class
    return [capturedImage].whereNotNull().toList();
  }
}

extension on FilePickerResult {
  /// validate current selected files extension  with passed allowed extension
  bool validateSelectedPaths(List<String> allowedExtensions) {
    if (paths.isNotEmpty) {
      /// TODO : only check the first file because multiple selection is always false
      /// TODO : in case use multiple selection this section should be refactored
      if (allowedExtensions.contains(
          p.extension(paths[0].toString()).replaceAll('.', '').toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
