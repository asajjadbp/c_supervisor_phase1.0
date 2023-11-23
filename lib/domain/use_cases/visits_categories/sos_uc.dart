import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/sos_list_model.dart';
import '../../repositories/visits_categories/sos_repo.dart';

class SosUC {
  SOSRepo sosRepo;
  SosUC(this.sosRepo);
  Future<BaseResponse<SOSListModel?>> getSOS(int visitID, int categoryID) {
    return sosRepo.getSOS(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
