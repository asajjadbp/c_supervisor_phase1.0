import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onRetryPressed,
    this.errorWidgetPadding = EdgeInsets.zero,
  });

  final String? message;
  final void Function()? onRetryPressed;
  final EdgeInsets errorWidgetPadding;

  bool get isMessageAvailable => message != null && message!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: errorWidgetPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   'assets/custom_icons/ic_error.svg',
          //   width: 65.w,
          //   height: 65.h,
          // ),
          Separator.spacer(20.h),
          Text(
            'not found',
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeightExt.extraBold,
              fontSize: 23.sp,
            ),
          ),
          if (isMessageAvailable) ...[
            Separator.spacer(20.h),
            Text(
              message!,
              style: context.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeightExt.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
          Separator.spacer(14.h),
          // CustomBtn(
          //   heightBtn: 36.h,
          //   widthBtn: 100.w,
          //   textBtn: 'error',
          //   colorBtn: Colors.grey,
          //   textcolorbtn: Colors.grey,
          //   bordercolorBtn: Colors.grey,
          //   buttonAction: onRetryPressed,
          // ),
        ],
      ),
    );
  }
}
