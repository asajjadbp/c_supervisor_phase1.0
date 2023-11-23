import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_expiry_list_model.dart';


abstract class VisitExpiryRepo {
  Future<BaseResponse<VisitExpiryListModel?>> getVisitExpiry({
    required int visitID,
    required int categoryID,
  });
}
