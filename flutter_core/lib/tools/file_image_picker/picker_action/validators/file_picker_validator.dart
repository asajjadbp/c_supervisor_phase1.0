import 'dart:io';

import '../../file_image_picker.dart';

/// Object that validates the selected files against [PickerProperties]
///
/// Ensures that the file(s)/image(s) count doesn't exceed the [PickerProperties.maxAllowedFileCount]
/// Ensures that the file(s)/image(s) size doesn't exceed the [PickerProperties.maxAllowedFileSizeInMB]
class FilesPickerValidation {
  final PickerProperties properties;
  final List<XFile>? files;
  final int currentlySelectedFileCount;

  FilesPickerValidation({
    this.files,
    required this.currentlySelectedFileCount,
    required this.properties,
  });

  /// Throws [FilePickerException.filesCountExceedsMaxLimitException] if [files.length] exceeds the [PickerProperties.maxAllowedFileCount]
  Future<void> validateFilesCountExceedingMaxLimit() async {
    if (currentlySelectedFileCount >= properties.maxAllowedFileCount) {
      throw FilePickerException.filesCountExceedsMaxLimitException(
        properties.maxAllowedFileCountErrorMessage,
      );
    }
  }

  /// Throws [FilePickerException.fileSizeExceedsMaxLimitException] if [files] exceeds the [PickerProperties.maxAllowedFileSizeInMB]
  ///
  /// in case the [PickerProperties.maxAllowedFileSizeInMB] is 0 then there is no limit
  /// if any file exceeds the [PickerProperties.maxAllowedFileSizeInMB]; throws [FilePickerException.fileSizeExceedsMaxLimitException]
  Future<void> validateFilesSizeExceedingMaxLimit() async {
    final hasFileSizeLimit = properties.maxAllowedFileSizeInMB != 0;
    if (hasFileSizeLimit) {
      return _checkEachFileSize();
    }
  }

  /// Checks if any file in the [files] exceeds the [maxAllowedFileSizeInMB]
  ///
  /// Throws [FileSizeExceedsMaxLimitException] in case a file exceeds the fileSize limit
  Future<void> _checkEachFileSize() async {
    for (final xFile in files ?? []) {
      final fileSizeInBytes = File(xFile.path).lengthSync();
      final fileSizeInMB = fileSizeInBytes / 1024 / 1024;
      if (fileSizeInMB > properties.maxAllowedFileSizeInMB) {
        throw FilePickerException.fileSizeExceedsMaxLimitException(
          properties.maxAllowedFileSizeInMBErrorMessage,
        );
      }
    }
  }
}
