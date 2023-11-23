import 'package:flutter/material.dart';

extension LocaleApiCode on Locale {
  int getLanguageId() {
    switch (languageCode) {
      case 'en':
        return 2;
      case 'ar':
        return 1;
      default:
        return 2;
    }
  }
}
