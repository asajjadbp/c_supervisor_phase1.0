import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/index.dart';
import 'package:c_supervisor/ui/pages/forget_password/otp/send_otp_content.dart';

class SendOtpPage extends StatelessWidget {
  const SendOtpPage({
    super.key,
    required this.changePasswordArgs,
  });

  final ChangePasswordArgs changePasswordArgs;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<OtpCubit>(
            create: (context) => OtpCubit(),
          ),
          BlocProvider<SendOTPCubit>(
            create: (context) =>
                SendOTPCubit(resetPasswordUC: GetIt.I<ResetPasswordUC>()),
          ),
          BlocProvider<SendEmailCubit>(
            create: (context) =>
                SendEmailCubit(resetPasswordUC: GetIt.I<ResetPasswordUC>()),
          ),
        ],
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
            child: SendOtpContent(changePasswordArgs),
          ),
        ));
  }
}
