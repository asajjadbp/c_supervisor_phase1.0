import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/index.dart';
import 'package:c_supervisor/utilities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:networking/client/networking_models/index.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../change_password_args.dart';
import '../widgets/timer_resend_btn.dart';

class SendOtpContent extends HookWidget {
  const SendOtpContent(this.changePasswordArgs, {Key? key}) : super(key: key);
  final ChangePasswordArgs changePasswordArgs;

  @override
  Widget build(BuildContext context) {
    final pinController = useTextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verification \ncode",
            style: TextStyle(
                color: Colors.white,
                fontSize: 35.sp,
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 20.h,
        ),
        Card(
            color: Colors.white70.withAlpha(240),
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black12,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 600.h,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SvgPicture.asset(
                    'assets/icons/message_ic.svg',
                    width: 120.w,
                    height: 120.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text(
                    "Please",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "We have sent the verification code to your email",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: PinCodeTextField(
                        autofocus: true,
                        hideCharacter: false,
                        controller: pinController,
                        highlight: true,
                        defaultBorderColor: Colors.grey,
                        hasTextBorderColor: Colors.grey,
                        highlightPinBoxColor: Colors.white,
                        pinBoxRadius: 10,
                        maxLength: 4,
                        onDone: (pinCode) {
                          /// send to api for validation
                          changePasswordArgs.pinCode = pinCode;
                          context.read<SendOTPCubit>().verifyCode(
                              otpModel: OtpModel(
                                userName: changePasswordArgs.userName,
                                code: changePasswordArgs.pinCode,
                                newPassword: '',
                              ),
                              successCall: () {
                                context.go(
                                    PreAuthRoutes.resetPassword.route.path,
                                    extra: changePasswordArgs);
                              });
                        },
                        pinBoxWidth: 60.w,
                        pinBoxHeight: 60.w,
                        wrapAlignment: WrapAlignment.spaceAround,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: const TextStyle(fontSize: 22.0),
                        pinBoxOuterPadding: const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                        keyboardType: TextInputType.number,
                      )),
                  AppBlocConsumer<SendOTPCubit, BaseResponse<EmptyModel?>>(
                      isConsumerAction: true,
                      onSuccessBuilder: (context, state) {
                        final isLoading = state.status == RequestStatus.loading;
                        return TimerResendButton(
                          userName: changePasswordArgs.userName ?? '',
                          isLoading: isLoading,
                        );
                      })
                ],
              ),
            ))
      ],
    );
  }
}
