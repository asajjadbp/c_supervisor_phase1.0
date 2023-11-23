import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_expiry_list_model.dart';
import '../../repositories/visits_categories/visit_expiry_repo.dart';

class VisitExpiryUC {
  VisitExpiryRepo visitExpiryRepo;
  VisitExpiryUC(this.visitExpiryRepo);
  Future<BaseResponse<VisitExpiryListModel?>> getVisitExpiry(
      int visitID, int categoryID) {
    return visitExpiryRepo.getVisitExpiry(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
