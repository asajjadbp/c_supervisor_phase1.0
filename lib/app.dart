import 'package:c_supervisor/di/environment_type.dart';
import 'package:c_supervisor/styles/index.dart';
import 'package:c_supervisor/ui/pages/splash/cubits/splash_cubit.dart';
import 'package:c_supervisor/utilities/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/index.dart';

import 'ui/bloc/auth_cubit.dart';
import 'ui/pages/login/cubit/login_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.environmentType});

  final EnvironmentType environmentType;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
            loginUC: GetIt.I<LoginUC>(),
          ),
        ),
        BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(
            authCubit: GetIt.I<AuthCubit>(),
          )..emitInitialAuthState(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            // builder: DevicePreview.appBuilder,
            title: 'C-Supervisor',
            theme: lightTheme,
          );
        },
      ),
    );
  }
}
