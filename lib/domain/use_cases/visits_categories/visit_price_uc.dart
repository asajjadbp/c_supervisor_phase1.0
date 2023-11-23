import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_price_list_model.dart';
import '../../repositories/visits_categories/visit_price_repo.dart';

class VisitPriceUC {
  VisitPriceRepo visitPriceRepo;
  VisitPriceUC(this.visitPriceRepo);
  Future<BaseResponse<VisitPriceListModel?>> getVisitPrice(
      int visitID, int categoryID) {
    return visitPriceRepo.getVisitPrice(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
