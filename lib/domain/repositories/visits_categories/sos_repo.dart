import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/sos_list_model.dart';

abstract class SOSRepo {
  Future<BaseResponse<SOSListModel?>> getSOS({
    required int visitID,
    required int categoryID,
  });
}
