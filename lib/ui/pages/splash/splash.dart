import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:networking/client/networking_models/index.dart';
import 'cubits/splash_cubit.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBlocConsumer<SplashCubit, BaseResponse<void>>(
      listenerCallBack: (ctx, state) {
        _onStateChanged(ctx);
      },
      onSuccessBuilder: (ctx, state) {
        return Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/splash_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/supervisor_logo.png',
                height: 165,
                width: 250,
              ),
            ),
          ),
        );
      },
      retryCallback: () => context.read<SplashCubit>().emitAuthorizedState(),
    );
  }

  void _onStateChanged(BuildContext context) {
    context.read<SplashCubit>().emitUnauthorizedException(Exception('errr'));
  }
}
