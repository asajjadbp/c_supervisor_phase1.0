import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class UserCheckInRepo {
  Future<BaseResponse<EmptyModel?>> insertCheckIn(
      UserCheckInModel userCheckInModel);
}
