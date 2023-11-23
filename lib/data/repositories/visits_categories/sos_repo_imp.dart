import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/sos_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/sos_list_model.dart';

class SOSRepoImp implements SOSRepo {
  ApplicationRemoteDS applicationRemoteDS;
  SOSRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<SOSListModel?>> getSOS(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getSOS(
      visitID,
      categoryID,
    );
  }
}
