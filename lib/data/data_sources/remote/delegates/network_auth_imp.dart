import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/ui/bloc/auth_cubit.dart';
import 'package:networking/client/networking_models/index.dart';

class NetworkAuthImp extends NetworkAuthDelegate {
  NetworkAuthImp({
    required this.secureStorageClient,
    // required this.authRepo,
    required this.authCubit,
  });

  final AppSecureStorageClient secureStorageClient;
  // final AuthRepo authRepo;
  final AuthCubit authCubit;

  @override
  Future<String> getToken() async {
    return (await secureStorageClient.getStoredToken())?.accessToken ?? '';
  }

  @override
  dynamic onInvalidResponse() {
    authCubit.logout();
  }

  @override
  Future<void> onRefreshFail() async {
    authCubit.emitUnauthorizedState();
  }

  @override
  Future<String?> refreshToken() async {
    return null;
  
    // return authRepo.refreshToken();
  }
}