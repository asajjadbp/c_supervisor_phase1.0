import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/di/environment_type.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:c_supervisor/ui/pages/login/cubit/login_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:networking/client/networking_models/index.dart';
import '../../../utilities/router/global_routes.dart';

class LoginContent extends HookWidget {
  LoginContent({
    super.key,
  });

  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    _intiTextController();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBlocConsumer<LoginCubit, BaseResponse<UserDataModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        return Column(
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Please Login to your account ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 36.0.h),
            AbsorbPointer(
              absorbing: isLoading,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField.withLightBorder(
                      myController: emailController,
                      labelText: 'User name',
                      contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (password) => ValidatorFactory.required(
                        '',
                        'Required Username',
                      ).validated(password).errorMessage,
                    ),
                    Separator.spacer(25.0.h),
                    PasswordTextField.withLightBorder(
                      myController: passwordController,
                      contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                      prefixIcon: const Icon(
                        Icons.lock_open,
                        color: Colors.white,
                      ),
                      labelText: 'password',
                      validator: (password) => ValidatorFactory.required(
                        '',
                        'Required password',
                      ).validated(password).errorMessage,
                    ),
                    Separator.spacer(12.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: UnderlinedTextButton(
                        onPressed: () => context
                            .push(PreAuthRoutes.forgetPassword.route.path),
                        text: 'Forget Password ?',
                        borderColor: Colors.white,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeightExt.bold,
                              fontSize: 12.sp,
                            ),
                      ),
                    ),
                    Separator.spacer(55.h),
                    LoadingButton(
                      theme: theme.copyWith(
                          cardColor: Colors.white, primaryColor: Colors.white),
                      text: 'Login',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeightExt.bold,
                        fontSize: 14.sp,
                      ),
                      borderRadius: 12,
                      btnColor: Colors.white,
                      btnHeight: 60.h,
                      btnWidth: double.infinity,
                      colorScheme: colorScheme,
                      isLoading: isLoading,
                      isDisabled: false,
                      onPressed: () => _validateLoginForm(context),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
      isConsumerAction: true,
    );
  }

  ///  validate on input
  void _validateLoginForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            successCall: () => _navigateToHome(context),
            userName: emailController.text,
            password: passwordController.text,
          );
    }
  }

  /// navigate to home in case of user authenticated
  void _navigateToHome(BuildContext context) {
    /// authorize user
    // context.read<AuthCubit>().emit(AuthorizedState());
    GetIt.I<AuthCubit>().authorizeUser();
  }

  /// initialize text controller
  void _intiTextController() {
    final inDebugMode =
        GetIt.I<EnvironmentType>() == EnvironmentType.development && kDebugMode;
    emailController = useTextEditingController(
      // text: inDebugMode ? 'myossry@victorylink.com' : null,
      text: inDebugMode ? '101005' : null,
    );
    passwordController = useTextEditingController(
      // text: inDebugMode ? 'Mm123456Dd!' : null,
      text: inDebugMode ? '101005' : null,
    );
  }
}
