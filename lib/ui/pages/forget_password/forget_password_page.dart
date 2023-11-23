import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/common_reusable/brand_reusable.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/index.dart';
import 'package:c_supervisor/ui/pages/forget_password/forget_password_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendEmailCubit>(
      create: (context) =>
          SendEmailCubit(resetPasswordUC: GetIt.I<ResetPasswordUC>()),
      child: BrandReusable.withAnyHeader(
        bgImage: const AssetImage(
          'assets/backgrounds/splash_bg.png',
        ),
        padding: EdgeInsets.only(top: 50.h),
        child: Padding(
          padding: EdgeInsets.only(
            left: 26.w,
            right: 26.w,
          ),
          child: ForgetPasswordContent(),
        ),
      ),
    );
  }
}
