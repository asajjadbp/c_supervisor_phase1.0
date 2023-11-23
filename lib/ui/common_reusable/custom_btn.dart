import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBtn extends StatelessWidget {
  final double widthBtn;
  final double heightBtn;
  final double marginTop;
  final double? btnPadding;
  final String textBtn;
  final Color? colorBtn;
  final Color? bordercolorBtn;
  final Color? textcolorbtn;
  final void Function()? buttonAction;
  final bool isDisabled;
  final double? borderRadius;

  const CustomBtn({
    super.key,
    required this.widthBtn,
    required this.heightBtn,
    this.marginTop = 0,
    required this.textBtn,
    this.buttonAction,
    required this.textcolorbtn,
    this.btnPadding,
    this.colorBtn,
    this.bordercolorBtn,
    this.isDisabled = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(top: marginTop),
      width: widthBtn,
      height: heightBtn,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: (textcolorbtn != null) ? textcolorbtn! : colorScheme.secondary, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
          ),
          backgroundColor: (colorBtn != null) ? colorBtn! : Colors.transparent,
          padding: EdgeInsets.all(btnPadding ?? 0.0),
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
          side: BorderSide(
            width: 1.0,
            color: (bordercolorBtn != null) ? bordercolorBtn! : colorBtn!,
          ),
        ),
        onPressed: isDisabled ? null : buttonAction,
        child: Text(
          textBtn,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: (textcolorbtn != null)
                    ? textcolorbtn!
                    : colorScheme.secondary,
              ),
        ),
      ),
    );
  }
}
