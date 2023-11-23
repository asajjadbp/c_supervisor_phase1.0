import 'package:c_supervisor/data/data_sources/remote/application_remote_ds.dart';
import 'package:c_supervisor/data/models/visits_categories_list_model.dart';
import 'package:c_supervisor/domain/repositories/visits_categories_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

class VisitsCategoriesImp implements VisitsCategoriesRepo {
  ApplicationRemoteDS applicationRemoteDS;
  VisitsCategoriesImp(this.applicationRemoteDS);
  @override
  Future<BaseResponse<VisitsCategoriesListModel?>> getVisitsCategories(
      int visitID) async {
    return applicationRemoteDS.getVisitsCategories(visitsID: visitID);
  }
}
