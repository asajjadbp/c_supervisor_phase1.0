import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_price_list_model.dart';


abstract class VisitPriceRepo {
  Future<BaseResponse<VisitPriceListModel?>> getVisitPrice({
    required int visitID,
    required int categoryID,
  });
}
