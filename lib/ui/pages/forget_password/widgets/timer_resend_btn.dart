import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/otp_cubit.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/send_email_cubit.dart';
import 'package:c_supervisor/ui/pages/forget_password/widgets/timer_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/otp_state.dart';

class TimerResendButton extends StatelessWidget {
  const TimerResendButton(
      {Key? key, required this.userName, required this.isLoading})
      : super(key: key);
  final String userName;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(children: [
      Container(
        width: 60.0,
        padding: const EdgeInsets.only(top: 50, right: 4.0),
        child: const TimerUI(
          otpTimerSeconds: 120,
        ),
      ),
      const Divider(
        height: 70,
        color: null,
      ),
      BlocBuilder<OtpCubit, OtpState>(builder: (context, state) {
        /// TODO : replace it with loading btn
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: LoadingButton(
            theme: theme.copyWith(
                cardColor: primaryColor, primaryColor: Colors.white),
            text: 'Resend',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeightExt.bold,
              fontSize: 14.sp,
            ),
            borderRadius: 12,
            btnColor: primaryColor,
            btnHeight: 60.h,
            isLoading: isLoading,
            btnWidth: double.infinity,
            colorScheme: colorScheme,
            isDisabled: (state is TimerBegins),
            onPressed: () => _resendPinCode(context, userName),
          ),
        );
      })
    ]);
  }

  _resendPinCode(BuildContext context, String userName) async {
    await context.read<SendEmailCubit>().forgetPassword(
        userName: userName,
        successCall: () {
          context.read<OtpCubit>().startTimer();
        });
  }
}
