import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class AuthRepo {
  Future<BaseResponse<UserDataModel?>> login({
    required LoginModel loginModel,
  });

  Future<BaseResponse<LastUserCheckInStatusModel?>> validateSupervisorCheckIN({
    required int userId,
  });
}
