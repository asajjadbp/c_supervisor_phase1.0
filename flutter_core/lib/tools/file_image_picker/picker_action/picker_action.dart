import 'dart:async';

import '../file_image_picker.dart';
import 'validators/file_picker_validator.dart';

/// Abstraction for file/image picker actions
///
/// Used for the file/image picker actions
abstract class PickerAction {
  /// Used in child classes to
  FileImagePicker fileImagePicker = FileImagePicker();

  /// Properties of the picker [actionName, maxFileSize, maxFileCount]
  PickerProperties properties;

  ///Primary Constructor
  PickerAction(this.properties);

  /// Opens picker to enable selecting and retrieving media files (image(s)/file(s)) and validates them
  /// Returns list of [XFile] with the selected file(s)
  /// [currentlySelectedFileCount]
  ///
  /// in case of [GalleryPickerAction] it opens the gallery and prompts the user to select images
  /// in case of [FilesPickerAction] it opens the files explorer and prompts the user to select files
  /// in case of [CameraPickerAction] it opens the camera app to prompt the user to capture image
  /// Returns a list of files/images to be handled by the caller
  ///
  /// Throws [FilePickerException.filesCountExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileCount]
  /// Throws [FilePickerException.fileSizeExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileSizeInMB]
  Future<List<XFile>> retrieveMediaFilesFromSource(
      int currentlySelectedFileCount);

  /// Throws [FilePickerException.filesCountExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileCount]
  Future<void> validateFilesCountExceedingMaxLimit(
      int currentlySelectedFileCount) async {
    final validator = FilesPickerValidation(
      currentlySelectedFileCount: currentlySelectedFileCount,
      properties: properties,
    );
    await validator.validateFilesCountExceedingMaxLimit();
  }

  /// Throws [FilePickerException.fileSizeExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileSizeInMB]
  Future<void> validateFilesSizeExceedingMaxLimit(
      List<XFile> files, int currentlySelectedFileCount) async {
    final validator = FilesPickerValidation(
      files: files,
      currentlySelectedFileCount: currentlySelectedFileCount,
      properties: properties,
    );
    await validator.validateFilesSizeExceedingMaxLimit();
  }

  /// Override isEqual to be able to prevent duplicates in HashSet
  @override
  bool operator ==(Object other) {
    return toString() == other.toString();
  }
}
