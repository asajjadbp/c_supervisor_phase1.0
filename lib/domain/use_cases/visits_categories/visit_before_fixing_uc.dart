import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_before_fixing_list_model.dart';
import '../../repositories/visits_categories/visit_before_fixing_repo.dart';

class VisitBeforeFixingUC {
  VisitBeforeFixingRepo visitBeforeFixingRepo;
  VisitBeforeFixingUC(this.visitBeforeFixingRepo);
  Future<BaseResponse<VisitBeforeFixingListModel?>> getVisitBeforeFixing(
      int visitID, int categoryID) {
    return visitBeforeFixingRepo.getVisitBeforeFixing(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
