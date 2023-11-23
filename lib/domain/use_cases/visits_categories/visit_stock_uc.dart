import 'package:c_supervisor/domain/repositories/visits_categories/visit_stock_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_stock_list_model.dart';

class VisitStockUC {
  VisitStockRepo visitStockRepo;
  VisitStockUC(this.visitStockRepo);
  Future<BaseResponse<VisitStockListModel?>> getVisitStock(
      int visitID, int categoryID) {
    return visitStockRepo.getVisitStock(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
