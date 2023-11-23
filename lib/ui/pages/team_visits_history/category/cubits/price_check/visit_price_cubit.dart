import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/visits_categories/visit_price_list_model.dart';
import '../../../../../../domain/use_cases/visits_categories/visit_price_uc.dart';

class VisitPriceCubit extends BaseAppCubit<VisitPriceListModel> {
  final VisitPriceUC visitPriceUC;
  final int visitID;
  final int categoryID;
  VisitPriceCubit({
    required this.visitPriceUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<VisitPriceListModel> loadItemsAtPage() async {
    final BaseResponse<VisitPriceListModel?> result;

    result = await networkCall(
      () => visitPriceUC.getVisitPrice(visitID, categoryID),
    );

    return result.data ?? VisitPriceListModel();
  }
}
