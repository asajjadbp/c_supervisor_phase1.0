import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// LoadingButton used to handle loading in actions used in consumer also handle
/// take loading state on the constructor responsible for showing hiding loading UI

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
    this.theme,
    this.text,
    this.loadingText,
    this.colorScheme,
    this.letterSpacing,
    required this.onPressed,
    this.btnWidth,
    this.btnHeight,
    this.btnColor,
    this.isLoading = false,
    this.style,
    this.icon,
    this.isDisabled = false,
    this.isCentered = true,
    this.iconSize = 20,
    this.contentPadding = EdgeInsets.zero,
    this.iconTextSpacing = 10,
    this.loadingIndicatorColor = Colors.white,
    this.isIconButton = false,
    this.borderRadius,
    this.elevation,
    this.borderSide,
  }) : super(key: key);

  final ThemeData? theme;
  final String? text;
  final String? loadingText;
  final ColorScheme? colorScheme;
  final VoidCallback onPressed;
  final Color? btnColor;
  final TextStyle? style;
  final Widget? icon;
  final double? btnWidth;
  final double? btnHeight;
  final bool isLoading;
  final bool isDisabled;
  final double? letterSpacing;
  final bool isCentered;
  final double iconSize;
  final double iconTextSpacing;
  final EdgeInsetsGeometry contentPadding;
  final Color loadingIndicatorColor;
  final bool isIconButton;
  final double? borderRadius;
  final double? elevation;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    final width = btnWidth ?? MediaQuery.of(context).size.width * .33;
    return SizedBox(
      width: width,
      height: btnHeight ?? 36.h,
      child: ElevatedButton(
        onPressed: _configureButtonOnPressed(),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          elevation: MaterialStateProperty.all(elevation),
          side: MaterialStateProperty.all(
            borderSide,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? 4.r,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey.withOpacity(0.5);
              } else {
                return btnColor;
              }
            },
          ),
        ),
        child: isLoading
            //Todo(design) : add animated container https://youtu.be/dOEKnNTRdq0?t=259
            ? SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: loadingIndicatorColor,
                  strokeWidth: context.width * .005,
                ),
              )
            : Padding(
                padding: contentPadding,
                child: Row(
                  mainAxisAlignment: isCentered
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null)
                      SizedBox(
                        child: icon!,
                        width: iconSize,
                        height: iconSize,
                      ),
                    if (icon != null && !isIconButton)
                      Separator.spacer(iconTextSpacing),
                    if (text != null && !isIconButton)
                      Text(
                        text!,
                        style: style ??
                            context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeightExt.bold,
                              letterSpacing: letterSpacing,
                              fontSize: 12.sp,
                              color: context.theme.scaffoldBackgroundColor,
                            ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  VoidCallback? _configureButtonOnPressed() {
    return isDisabled
        ? null
        : isLoading
            ? () {}
            : () {
                /// if there is any keyboard opened dismiss it on submit
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                onPressed.call();
              };
  }
}
