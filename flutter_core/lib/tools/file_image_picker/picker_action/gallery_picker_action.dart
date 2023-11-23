import 'package:image_picker/image_picker.dart';

import 'picker_action.dart';
import 'picker_properties.dart';

/// Object that handles selecting images from the gallery
///
/// Used to prompt the user to select a single image or multiple ones from the phone's gallery
class GalleryPickerAction extends PickerAction {
  GalleryPickerAction(PickerProperties properties) : super(properties);

  /// Returns a list of [XFile] containing the image(s) that the user selected
  ///
  /// Throws [FilePickerException.filesCountExceedsMaxLimitException] if any image in [files] exceeds [properties.maxAllowedFileCount]
  /// Throws [FilePickerException.fileSizeExceedsMaxLimitException] if any image in [files] exceeds [properties.maxAllowedFileSizeInMB]
  @override
  Future<List<XFile>> retrieveMediaFilesFromSource(
      int currentlySelectedFileCount) async {
    /// TODO(refactor): use [allowMultiple] to enable max allowed file
    final allowMultiple = properties.maxAllowedFileCount > 1;

    await validateFilesCountExceedingMaxLimit(currentlySelectedFileCount);
    final List<XFile> files;

    // if (allowMultiple) {
    //   files = await fileImagePicker
    //       .pickMultipleImagesFromGallery(properties.imageQuality);
    // } else {
    //   files =
    //       await fileImagePicker.pickImageFromGallery(properties.imageQuality);
    // }

    files = await fileImagePicker.pickImageFromGallery(properties.imageQuality);

    await validateFilesSizeExceedingMaxLimit(files, currentlySelectedFileCount);
    // await validateFiles(files);
    return files;
  }

  //Todo: add validate files that call `validator.validate`
}
