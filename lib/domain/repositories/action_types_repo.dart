import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class ActionTypeRepo {
  Future<BaseResponse<CommonDataListModel?>> fetchActionTypeList({
    required bool isAttend,
  });

  Future<BaseResponse<EmptyModel?>> insertActionType(
      AddActionTypeModel addActionTypeModel);
}
