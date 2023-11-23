import 'package:c_supervisor/data/models/visits_categories/visit_stock_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

abstract class VisitStockRepo {
  Future<BaseResponse<VisitStockListModel?>> getVisitStock({
    required int visitID,
    required int categoryID,
  });
}
