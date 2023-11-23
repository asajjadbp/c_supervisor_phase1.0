import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  Size get size {
    return MediaQuery.of(this).size;
  }

  double get height {
    return size.height;
  }

  double get width {
    return size.width;
  }
}
