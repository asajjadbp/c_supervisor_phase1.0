import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text_field.dart';

class PasswordTextField extends CustomTextField {
  PasswordTextField.withDarkBorder({
    required super.labelText,
    super.key,
    super.myController,
    super.hintText,
    super.keyboardType,
    super.validator,
    super.prefixIcon,
    super.mode,
    super.contentPadding,
    super.isEnabled = true,
    super.isReadOnly = false,
    super.height,
  })  : suffixColor = Colors.black,
        super.withDarkBorder();

  PasswordTextField.withLightBorder({
    required super.labelText,
    super.key,
    super.myController,
    super.hintText,
    super.keyboardType,
    super.validator,
    super.prefixIcon,
    super.mode,
    super.contentPadding,
    super.isEnabled = true,
    super.isReadOnly = false,
    super.height,
  })  : suffixColor = Colors.white,
        super.withLightBorder();

  final Color suffixColor;

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState<bool>(false);
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: textColor,
          fontSize: 14.sp,
          fontWeight: FontWeightExt.regular,
        );
    return TextFormField(
      validator: validator,
      autovalidateMode: mode,
      controller: myController,
      decoration: decoration?.copyWith(
        contentPadding: contentPadding,
        suffixIcon: IconButton(
          onPressed: () {
            isPasswordVisible.value = !isPasswordVisible.value;
          },
          icon: Icon(
            isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
          ),
          color: suffixColor,
        ),
        counterText: '',
      ),
      style: textStyle,
      textAlign: TextAlign.left,
      enabled: isEnabled,
      readOnly: isReadOnly,
      obscureText: !isPasswordVisible.value,
      maxLength: maxLength,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
