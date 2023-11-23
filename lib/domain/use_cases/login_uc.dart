import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../data/models/index.dart';

class LoginUC {
  final AuthRepo authRepo;

  LoginUC(this.authRepo);

  Future<BaseResponse<UserDataModel?>> login({
    required LoginModel loginModel,
  }) async {
    return authRepo.login(loginModel: loginModel);
  }

  Future<BaseResponse<LastUserCheckInStatusModel?>> validateSupervisorCheckIN({
    required int userId,
  }) async {
    return authRepo.validateSupervisorCheckIN(userId: userId);
  }
}
