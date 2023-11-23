import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/visits_categories/visit_stock_list_model.dart';
import '../../../../../../domain/use_cases/visits_categories/visit_stock_uc.dart';

class VisitStockCubit extends BaseAppCubit<VisitStockListModel> {
  final VisitStockUC visitStockUC;
  final int visitID;
  final int categoryID;
  VisitStockCubit({
    required this.visitStockUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<VisitStockListModel> loadItemsAtPage() async {
    final BaseResponse<VisitStockListModel?> result;

    result = await networkCall(
      () => visitStockUC.getVisitStock(visitID, categoryID),
    );

    return result.data ?? VisitStockListModel();
  }
}
