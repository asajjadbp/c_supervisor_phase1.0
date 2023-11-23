import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class UserCheckInUC {
  final UserCheckInRepo userCheckInRepo;

  UserCheckInUC(this.userCheckInRepo);

  Future<BaseResponse<EmptyModel?>> insertCheckIn(
      UserCheckInModel userCheckInModel) async {
    return await userCheckInRepo.insertCheckIn(userCheckInModel);
  }
}
