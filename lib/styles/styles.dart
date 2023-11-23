import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style {
  // final customPageBorderRadius = BorderRadius.only(
  //   topLeft: Radius.circular(15),
  //   topRight: Radius.circular(15),
  // );
  //
  // static ThemeData getThemeData() {
  //   return ThemeData(
  //     brightness: Brightness.light,
  //     appBarTheme: const AppBarTheme(brightness: Brightness.dark),
  //     colorScheme: const ColorScheme.light().copyWith(
  //       primary: AppColors.lightPrimaryColor,
  //       secondary: AppColors.lightAccentColor,
  //       onSecondary: Colors.white,
  //     ),
  //     // inputDecorationTheme: InputDecoration(),
  //     inputDecorationTheme: const InputDecorationTheme(
  //       // hintStyle: ,
  //       // floatingLabelStyle: ,
  //       // border: ,
  //       errorStyle: TextStyle(
  //         color: const Color(0xffb00020),
  //         fontSize: 11,
  //         letterSpacing: .5,
  //         // fontWeight: FontWeightExt.medium,
  //       ),
  //     ),
  //     // textTheme: appTextTheme,
  //     primaryColor: AppColors.lightPrimaryColor,
  //     scaffoldBackgroundColor: AppColors.lightBackgroundColor,
  //     backgroundColor: AppColors.lightBackgroundColor,
  //     // pageTransitionsTheme: _pageTransitionsTheme,
  //     // textTheme: GoogleFonts.rubikTextTheme(ThemeData.light().textTheme),
  //     popupMenuTheme: PopupMenuThemeData(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(6),
  //       ),
  //     ),
  //     outlinedButtonTheme: ButtonStyles.lightOutlinedButtonTheme,
  //     elevatedButtonTheme: ButtonStyles.lightElevatedButtonTheme,
  //   );
  // }

  static const defaultBorderSide = BorderSide(
    color: Colors.white,
  );
  static const darkDefaultBorderSide = BorderSide(
    color: Colors.white,
  );
  static final textFieldEnabledBorders = OutlineInputBorder(
    borderSide: defaultBorderSide.copyWith(
      width: 1,
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(12.r),
  );
  static final darkTextFieldEnabledBorders = OutlineInputBorder(
    borderSide: defaultBorderSide.copyWith(
      width: 1,
      color: Colors.black.withOpacity(0.3),
    ),
    borderRadius: BorderRadius.circular(12.r),
  );
  static final textFieldFocusedBorder = OutlineInputBorder(
    borderSide: defaultBorderSide.copyWith(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(12.r),
  );
  static final darkTextFieldFocusedBorder = OutlineInputBorder(
    borderSide: defaultBorderSide.copyWith(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(12.r),
  );
  static final textFieldErrorBorder = OutlineInputBorder(
    borderSide: defaultBorderSide.copyWith(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(12.r),
  );
  static final textFieldBorder = OutlineInputBorder(
    borderSide: defaultBorderSide,
    borderRadius: BorderRadius.circular(12.r),
  );
  static final darkTextFieldBorder = OutlineInputBorder(
    borderSide: darkDefaultBorderSide,
    borderRadius: BorderRadius.circular(12.r),
  );

  static final floatingLabelStyle =
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
    final Color color =
        states.contains(MaterialState.error) ? Colors.red : Colors.white;
    return TextStyle(
      fontSize: 14.sp,
      color: color,
      fontWeight: FontWeight.normal,
    );
  });
  static final darkFloatingLabelStyle =
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
    final Color color =
        states.contains(MaterialState.error) ? Colors.red : Colors.black;
    return TextStyle(
      fontSize: 14.sp,
      color: color,
      fontWeight: FontWeight.normal,
    );
  });
  static final darkLabelStyle =
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
    final Color color = states.contains(MaterialState.error)
        ? Colors.red
        : Colors.black.withOpacity(.30);
    return TextStyle(
      fontSize: 14.sp,
      color: color,
      fontWeight: FontWeight.normal,
    );
  });
  static final darkErrorStyle = TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );
  static final lightTextFieldDecoration = InputDecoration(
    constraints: BoxConstraints(
      minHeight: 52.h,
    ),
    fillColor: Colors.white,
    labelText: '',
    enabledBorder: textFieldEnabledBorders,
    errorMaxLines: 10,
    border: textFieldBorder,
    errorBorder: textFieldErrorBorder,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 17.h,
    ),
    focusedBorder: textFieldFocusedBorder,
    suffixIconColor: Colors.white,
    floatingLabelStyle: floatingLabelStyle,
    labelStyle: floatingLabelStyle,
    counterText: '',
  );

  static final darkTextFieldDecoration = InputDecoration(
    constraints: BoxConstraints(
      minHeight: 52.h,
    ),
    fillColor: Colors.white,
    errorStyle: darkErrorStyle,
    labelText: '',
    enabledBorder: darkTextFieldEnabledBorders,
    errorMaxLines: 10,
    border: darkTextFieldBorder,
    errorBorder: textFieldErrorBorder,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 17.h,
    ),
    focusedBorder: darkTextFieldFocusedBorder,
    floatingLabelStyle: darkFloatingLabelStyle,
    labelStyle: darkLabelStyle,
    alignLabelWithHint: true,
    counterText: '',
  );
}
