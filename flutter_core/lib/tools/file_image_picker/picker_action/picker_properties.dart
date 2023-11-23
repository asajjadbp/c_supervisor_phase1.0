import '/flutter_core.dart';

/// Properties for the [PickerAction]
///
/// Contains all properties for initializing and creating a picker action
class PickerProperties {
  /// Action name that would be shown on the button
  final String actionName;

  /// Maximum file size (in MegaBytes) to be allowed by the picker
  final int maxAllowedFileSizeInMB;

  /// Maximum number of the files which can be picked (a non zero value)
  final int maxAllowedFileCount;

  /// Error message to be thrown for [FilesCountExceedsMaxLimitException]
  final String maxAllowedFileCountErrorMessage;

  /// Error message to be thrown for [FileSizeExceedsMaxLimitException]
  final String maxAllowedFileSizeInMBErrorMessage;

  /// error message to be thrown for extension not supported
  final String? fileNotSupportedErrorMessage;

  /// The allowed extensions for the file picker
  ///
  /// [allowedExtensions] might be provided (e.g. `[pdf, svg, jpg]`.)
  final List<String>? allowedExtensions;

  /// Image quality value
  ///
  /// only used in [GalleryPickerAction] and [CameraPickerAction]
  /// value ranges from 1 - 100; the more it is the higher the quality and the image size
  final int imageQuality;

  /// The Primary Constructor
  PickerProperties(
    this.actionName, {
    String? maxAllowedFileCountErrorMessage,
    String? maxAllowedFileSizeInMBErrorMessage,
    this.allowedExtensions,
    this.imageQuality = 30,
    this.maxAllowedFileCount = 1,
    this.maxAllowedFileSizeInMB = 0,
    this.fileNotSupportedErrorMessage,
  })  : maxAllowedFileCountErrorMessage = maxAllowedFileCountErrorMessage ??
            "You can't select over $maxAllowedFileCount files",
        maxAllowedFileSizeInMBErrorMessage = maxAllowedFileSizeInMBErrorMessage ??
            "One of the files you selected exceeds $maxAllowedFileSizeInMB MB",
        assert(maxAllowedFileCount > 0);
}
