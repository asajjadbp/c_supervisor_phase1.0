import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/visit_price_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/visit_price_list_model.dart';

class VisitPriceRepoImp implements VisitPriceRepo {
  ApplicationRemoteDS applicationRemoteDS;
  VisitPriceRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<VisitPriceListModel?>> getVisitPrice(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getVisitPrice(
      visitID,
      categoryID,
    );
  }
}
