import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

/// Handle Application Auth States. Used to set app root widget
///
/// *Available states*:
/// - [AuthorizedState] -> Registered and authenticated user, should show home
/// - [UnauthorizedState] -> User without authentication, should show login
/// - [FirstTimeAccessState] -> First time user, should show intro if any.
/// - [NavigateToMainState] -> Emitted  in case of navigating to main page
class AuthCubit extends Cubit<AuthState?> {
  AuthCubit({
    required this.appSecureStorageClient,
    required this.loginUC,
  }) : super(SplashState());

  static const storageKey = 'kAuthState';
  final AppSecureStorageClient appSecureStorageClient;
  final LoginUC loginUC;

  /// Authorizes the user and emits [AuthorizedState]
  ///
  /// it can only be used by registered user either with email & password or
  /// social authentication
  void authorizeUser() {
    emit(AuthorizedState());
  }

  void emitUnauthorizedState() {
    appSecureStorageClient.resetSecureStorage();
    emit(UnauthorizedState());
  }

  Future<void> logout() async {
    // await authClientUC.logout();
    // try {
    //   await appSecureStorageClient.resetSecureStorage();
    // } finally {
    //   emit(UnauthorizedState());
    // }
    await appSecureStorageClient.resetSecureStorage();
    emit(UnauthorizedState());
  }

  Future<LastUserCheckInStatusModel?> validateSupervisorCheckIN({
    required int userId,
  }) async {
    final response = await loginUC.validateSupervisorCheckIN(userId: userId);
    return response.hasError ? null : response.data;
  }

  /// TODO
  Future<Tokens?> getCurrentTokenModel() async {
    return appSecureStorageClient.getStoredToken();
  }
}
