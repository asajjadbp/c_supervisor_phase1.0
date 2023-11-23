import 'package:c_supervisor/ui/pages/forget_password/cubits/otp_cubit.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TimerUI extends StatelessWidget {
  const TimerUI({super.key, 
    required this.otpTimerSeconds,
  });

  final int otpTimerSeconds;

  @override
  Widget build(BuildContext context) {
    final int countDownTime = otpTimerSeconds;
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (blocContext, state) {
        final bool isTimerAppear =
            state is TimerBegins && context.read<OtpCubit>().canResend;
        if (isTimerAppear) {
          return TweenAnimationBuilder<Duration>(
            duration: Duration(seconds: countDownTime),
            tween: Tween(
              begin: Duration(seconds: countDownTime),
              end: Duration.zero,
            ),
            onEnd: () => context.read<OtpCubit>().endTimer(),
            builder: (BuildContext context, Duration value, Widget? child) {
              final minutes = value.inMinutes;
              final seconds = value.inSeconds % 60;

              return Text(
                '$minutes:$seconds',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 24.sp),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
