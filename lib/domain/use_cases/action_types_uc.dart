import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class ActionTypesUC {
  final ActionTypeRepo actionTypeRepo;

  ActionTypesUC(this.actionTypeRepo);

  Future<BaseResponse<CommonDataListModel?>> fetchActionTypeList(
      {required bool isAttend}) {
    return actionTypeRepo.fetchActionTypeList(isAttend: isAttend);
  }

  Future<BaseResponse<EmptyModel?>> insertActionType(
      AddActionTypeModel addActionTypeModel) {
    return actionTypeRepo.insertActionType(addActionTypeModel);
  }
}
