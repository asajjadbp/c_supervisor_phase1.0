import 'package:c_supervisor/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends HookWidget {
  /// [CustomTextField.withLightBorder]  used with screens with dark background
  CustomTextField.withLightBorder({
    super.key,
    this.myController,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.mode,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.height,
    this.suffixIconConstraints,
    this.contentPadding,
    this.maxLines = 1,
    this.maxLength = ConfigurationConstants.defaultInputTextLengthLimit,
    this.onTap,
    this.onChanged,
  })  : decoration = Style.lightTextFieldDecoration.copyWith(
            prefixIcon: prefixIcon,
            labelText: labelText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints,
            contentPadding: contentPadding),
        textColor = Colors.white;

  /// [CustomTextField.withDarkBorder]  used with screens with white background
  CustomTextField.withDarkBorder({
    super.key,
    this.myController,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.mode,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.height,
    this.suffixIconConstraints,
    this.contentPadding,
    this.maxLines,
    this.maxLength = ConfigurationConstants.defaultInputTextLengthLimit,
    this.onTap,
    this.onChanged,
  })  : decoration = Style.darkTextFieldDecoration.copyWith(
            prefixIcon: prefixIcon,
            labelText: labelText,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding),
        textColor = Colors.black;

  final TextEditingController? myController;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final double? height;
  final AutovalidateMode? mode;
  final InputDecoration? decoration;
  final bool isEnabled;
  final bool isReadOnly;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? contentPadding;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeightExt.regular,
        );
    return TextFormField(
      validator: validator,
      autovalidateMode: mode,
      controller: myController,
      decoration: decoration ?? Style.lightTextFieldDecoration,
      style: textStyle,
      // textAlign: TextAlign.right,
      enabled: isEnabled,
      readOnly: isReadOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
