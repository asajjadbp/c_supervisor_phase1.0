import 'package:flutter/material.dart';
import 'colors.dart';

// theming
ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: colorScheme,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: COLOR_ElEVATED_BUTTON,
    ),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   // border: BORDER_INPUT_DECORATION,
  //   // fillColor: Colors.grey.withOpacity(0.1),
  // ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
    ),
  ),
);

// variables
const lightDefaultScheme = ColorScheme.light();

var COLOR_ElEVATED_BUTTON = MaterialStateProperty.all<Color>(primaryColor);
var BORDER_INPUT_DECORATION = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none);
ColorScheme colorScheme = ColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  background: lightDefaultScheme.background,
  brightness: Brightness.light,
  error: red,
  onBackground: onBackground,
  onError: red,
  onPrimary: greyColor,
  onSecondary: secondaryColor,
  onSurface: secondaryColor,
  surface: lightGreyColor,
);
