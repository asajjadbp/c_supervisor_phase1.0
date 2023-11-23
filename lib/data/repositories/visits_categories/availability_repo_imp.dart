import 'package:c_supervisor/data/models/visits_categories/availability_list_model.dart';

import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/availability_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';

class AvailabilityRepoImp implements AvailabilityRepo {
  ApplicationRemoteDS applicationRemoteDS;
  AvailabilityRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<AvailabilityListModel?>> getAvailability(
      int visitID, int categoryID) async {
    return applicationRemoteDS.getAvailability(visitID, categoryID);
  }
}
