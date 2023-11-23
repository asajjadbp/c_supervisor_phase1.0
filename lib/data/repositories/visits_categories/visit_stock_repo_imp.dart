import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/visit_stock_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/visit_stock_list_model.dart';

class VisitStockRepoImp implements VisitStockRepo {
  ApplicationRemoteDS applicationRemoteDS;
  VisitStockRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<VisitStockListModel?>> getVisitStock(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getVisitStock(
      visitID,
      categoryID,
    );
  }
}
