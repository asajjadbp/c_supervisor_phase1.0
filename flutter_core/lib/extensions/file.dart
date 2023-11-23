import 'dart:io';

import '../flutter_core.dart';

extension XFileExtensions on XFile {
  /// Returns [File] from the supplied [XFile]
  File toFile() {
    return File(path);
  }
}

extension FileExtensions on File {
  /// Returns [XFile] from the supplied [File]
  XFile toXFile() {
    return XFile(path);
  }
}
