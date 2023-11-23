
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/rtv_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/rtv_list_model.dart';

class RTVRepoImp implements RTVRepo {
  ApplicationRemoteDS applicationRemoteDS;
  RTVRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<RTVListModel?>> getRTV(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getRTV(
      visitID,
      categoryID,
    );
  }
}
