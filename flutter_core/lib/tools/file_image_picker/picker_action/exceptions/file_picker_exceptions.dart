import '/flutter_core.dart';
import '../validators/file_picker_validator.dart';

/// File/Image picker Exception that's thrown by [FileImagePicker] when the selected file(s)/image(s) don't meet the expected limits
///
/// Exception types: [FilePickerException.filesCountExceedsMaxLimitException] or [FilePickerException.fileSizeExceedsMaxLimitException]
/// @see [FilesPickerValidation.validate], [PickerAction.validate]
class FilePickerException implements Exception {
  /// Exception message
  final String message;

  /// Primary constructor
  FilePickerException(this.message);

  /// Thrown when the file count exceeds the maximum allowed files count limit
  ///
  /// example: @see [FilesPickerValidation.validateFiles], [PickerAction.validate], [GalleryPickerAction], [FilesPickerAction]
  factory FilePickerException.filesCountExceedsMaxLimitException(
          String message) =>
      FilePickerException(message);

  /// Thrown when the file size exceeds the maximum allowed size limit per file
  ///
  /// example: @see [FilesPickerValidation.validateFiles], [PickerAction.validate], [GalleryPickerAction], [FilesPickerAction]
  factory FilePickerException.fileSizeExceedsMaxLimitException(
          String message) =>
      FilePickerException(message);

  /// Thrown when selected files extension not match the specified extensions
  factory FilePickerException.fileNotSupportedTypeException(String message) =>
      FilePickerException(message);

  @override
  String toString() => message;
}
