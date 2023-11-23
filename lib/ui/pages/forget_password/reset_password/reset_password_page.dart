import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/common_reusable/brand_reusable.dart';
import 'package:c_supervisor/ui/pages/forget_password/change_password_args.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/index.dart';
import 'package:c_supervisor/ui/pages/forget_password/reset_password/reset_password_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    super.key,
    required this.changePasswordArgs,
  });

  final ChangePasswordArgs changePasswordArgs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
        create: (context) =>
            ChangePasswordCubit(resetPasswordUC: GetIt.I<ResetPasswordUC>()),
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
            child: ResetPasswordContent(
              changePasswordArgs: changePasswordArgs,
            ),
          ),
        ));
  }
}
