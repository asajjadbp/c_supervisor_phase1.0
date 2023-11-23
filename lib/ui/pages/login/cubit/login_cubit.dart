import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/base_app_cubit.dart';

/// [LoginCubit] hold auth process network calls
class LoginCubit extends BaseAppCubit<UserDataModel> {
  LoginCubit({required this.loginUC});

  ///[authClientUC] hold logic for user authorization
  final LoginUC loginUC;

  Future<void> login({
    required String userName,
    required String password,
    Function()? successCall,
  }) async {
    await networkCall(
      successCall: successCall,
      () => loginUC.login(
        loginModel:
            LoginModel(userName: userName, password: password, langID: 1),
      ),
    );
  }
}
