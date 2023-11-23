import 'package:c_supervisor/ui/bloc/index.dart';

import '../../index.dart';

/// [SplashCubit] to get date before main screen then route
class SplashCubit extends BaseAppCubit<void> {
  SplashCubit({required this.authCubit});

  final AuthCubit authCubit;

  Future<void> emitInitialAuthState() async {
    //TODO: Remove this delay
    await Future.delayed(const Duration(seconds: 5));
    final token = await authCubit.getCurrentTokenModel();

    if (token != null) {
      final lastUserCheckInStatus = await authCubit.validateSupervisorCheckIN(
          userId:
              GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ??
                  0);
      if (lastUserCheckInStatus != null) {
        if (lastUserCheckInStatus.dataList?.checkedIn ?? false) {
          emitAuthorizedState();
        } else {
          emitUnauthorizedState();
        }
      } else {
        emitUnauthorizedState();
      }
    } else {
      emitUnauthorizedState();
    }
  }

  void emitUnauthorizedState() {
    authCubit.emitUnauthorizedState();
  }

  void emitAuthorizedState() {
    authCubit.authorizeUser();
  }
}
