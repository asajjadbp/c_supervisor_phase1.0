import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/rtv_list_model.dart';
import '../../repositories/visits_categories/rtv_repo.dart';

class RtvUC {
  RTVRepo rtvRepo;
  RtvUC(this.rtvRepo);
  Future<BaseResponse<RTVListModel?>> getRTV(int visitID, int categoryID) {
    return rtvRepo.getRTV(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
