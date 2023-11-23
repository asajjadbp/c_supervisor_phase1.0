import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/rtv_list_model.dart';

abstract class RTVRepo {
  Future<BaseResponse<RTVListModel?>> getRTV({
    required int visitID,
    required int categoryID,
  });
}
