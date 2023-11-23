import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return theme.textTheme;
  }

  ColorScheme get colorScheme {
    return theme.colorScheme;
  }
}
