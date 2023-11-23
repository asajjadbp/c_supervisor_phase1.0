import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/use_cases/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';
class CheckInCubit extends BaseAppCubit<EmptyModel?> {
  final UserCheckInUC userCheckInUC;

  CheckInCubit(this.userCheckInUC);

  Future<BaseResponse<EmptyModel?>> insertCheckIn({
    required UserCheckInModel userCheckInModel,
  }) async {
    return await networkCall(
      () => userCheckInUC.insertCheckIn(userCheckInModel),
    );
  }
}
