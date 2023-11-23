import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/add_action_type_model.dart';
import 'package:c_supervisor/data/models/common_data_list_model.dart';
import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class ActionTypesRepoImp implements ActionTypeRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  ActionTypesRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<CommonDataListModel?>> fetchActionTypeList(
      {required bool isAttend}) {
    return applicationRemoteDS.fetchActionTypeList(isAttend: isAttend);
  }

  @override
  Future<BaseResponse<EmptyModel?>> insertActionType(
      AddActionTypeModel addActionTypeModel) {
    return applicationRemoteDS.insertActionType(addActionTypeModel);
  }
}
