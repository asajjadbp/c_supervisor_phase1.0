
import '/flutter_core.dart';

/// Object that handles file selection action
///
/// Used to prompt the user to select either single or multiple files from the user's phone storage
class FilesPickerAction extends PickerAction {
  //Todo: Handle selecting multiple files from iOS
  FilesPickerAction(PickerProperties properties) : super(properties);

  /// Returns a list of [XFile] containing the file(s) that the user selected
  ///
  /// Throws [FilePickerException.filesCountExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileCount]
  /// Throws [FilePickerException.fileSizeExceedsMaxLimitException] if any file in [files] exceeds [properties.maxAllowedFileSizeInMB]
  @override
  Future<List<XFile>> retrieveMediaFilesFromSource(
      int currentlySelectedFileCount) async {
    await validateFilesCountExceedingMaxLimit(currentlySelectedFileCount);
    final files = await fileImagePicker.pickFile(
      properties: properties,
      maxAllowedFileCount: properties.maxAllowedFileCount,
      allowedExtensions: properties.allowedExtensions,
    );
    await validateFilesSizeExceedingMaxLimit(files, currentlySelectedFileCount);
    return files;
  }
}
