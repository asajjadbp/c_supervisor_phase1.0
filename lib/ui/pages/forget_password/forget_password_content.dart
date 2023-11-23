import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:c_supervisor/ui/pages/forget_password/cubits/index.dart';
import 'package:c_supervisor/ui/pages/forget_password/index.dart';
import 'package:c_supervisor/utilities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:networking/client/networking_models/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordContent extends HookWidget {
  ForgetPasswordContent({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final userName = useTextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Forget \npassword ?",
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
                    'assets/icons/lock_ic.svg',
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
                    "Enter the username associated with your account and we'll send an email instruction to reset your password.",
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
                    child: Form(
                      key: _formKey,
                      child: CustomTextField.withDarkBorder(
                        labelText: 'Username',
                        myController: userName,
                        contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (password) => ValidatorFactory.required(
                          '',
                          'Required Username',
                        ).validated(password).errorMessage,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: AppBlocConsumer<SendEmailCubit,
                            BaseResponse<EmptyModel?>>(
                        isConsumerAction: true,
                        onSuccessBuilder: (context, state) {
                          final isLoading =
                              state.status == RequestStatus.loading;
                          return LoadingButton(
                            theme: theme.copyWith(
                                cardColor: primaryColor,
                                primaryColor: Colors.white),
                            text: 'Send',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeightExt.bold,
                              fontSize: 14.sp,
                            ),
                            borderRadius: 12,
                            btnColor: primaryColor,
                            btnHeight: 60.h,
                            btnWidth: double.infinity,
                            colorScheme: colorScheme,
                            isLoading: isLoading,
                            isDisabled: false,
                            onPressed: () =>
                                _sendResetPasswordEmail(context, userName),
                          );
                        }),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  _sendResetPasswordEmail(
      BuildContext context, TextEditingController userName) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SendEmailCubit>().forgetPassword(
          userName: userName.text,
          successCall: () {
            context.go(PreAuthRoutes.otpVerificationPage.route.path,
                extra:
                    ChangePasswordArgs(userName: userName.text, pinCode: ''));
          });
    }
  }
}
