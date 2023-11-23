import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/user_checkin_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class UserCheckInRepoImp implements UserCheckInRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  UserCheckInRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<EmptyModel?>> insertCheckIn(
      UserCheckInModel userCheckInModel) {
    return applicationRemoteDS.insertCheckIn(userCheckInModel);
  }
}
