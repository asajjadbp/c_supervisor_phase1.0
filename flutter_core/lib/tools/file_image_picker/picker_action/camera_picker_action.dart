
import '/flutter_core.dart';

/// Object that handles Camera capture action
///
/// Used to prompt the user to capture an image from his phone's camera
class CameraPickerAction extends PickerAction {
  CameraPickerAction(PickerProperties properties) : super(properties);

  /// Returns a list of [XFile] containing the image that the user captured using the camera
  ///
  /// Throws [FilePickerException.fileSizeExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileSizeInMB]
  @override
  Future<List<XFile>> retrieveMediaFilesFromSource(
      int currentlySelectedFileCount) async {
    await validateFilesCountExceedingMaxLimit(currentlySelectedFileCount);
    final files = await fileImagePicker.captureImage(properties.imageQuality);
    await validateFilesSizeExceedingMaxLimit(files, currentlySelectedFileCount);
    return files;
  }
}
