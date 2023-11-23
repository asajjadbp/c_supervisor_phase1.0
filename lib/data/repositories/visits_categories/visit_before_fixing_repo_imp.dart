import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/visit_before_fixing_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/visit_before_fixing_list_model.dart';

class VisitBeforeFixingRepoImp implements VisitBeforeFixingRepo {
  ApplicationRemoteDS applicationRemoteDS;
  VisitBeforeFixingRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<VisitBeforeFixingListModel?>> getVisitBeforeFixing(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getVisitBeforeFixing(
      visitID,
      categoryID,
    );
  }
}
