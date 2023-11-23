import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/visit_expiry_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/visit_expiry_list_model.dart';

class VisitExpiryRepoImp implements VisitExpiryRepo {
  ApplicationRemoteDS applicationRemoteDS;
  VisitExpiryRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<VisitExpiryListModel?>> getVisitExpiry(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getVisitExpiry(
      visitID,
      categoryID,
    );
  }
}
