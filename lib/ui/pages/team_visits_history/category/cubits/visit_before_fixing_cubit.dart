import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../data/models/visits_categories/visit_before_fixing_list_model.dart';
import '../../../../../domain/use_cases/visits_categories/visit_before_fixing_uc.dart';

class VisitBeforeFixingCubit extends BaseAppCubit<VisitBeforeFixingListModel> {
  final VisitBeforeFixingUC visitBeforeFixingUC;
  final int visitID;
  final int categoryID;
  VisitBeforeFixingCubit({
    required this.visitBeforeFixingUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<VisitBeforeFixingListModel> loadItemsAtPage() async {
    final BaseResponse<VisitBeforeFixingListModel?> result;

    result = await networkCall(
      () => visitBeforeFixingUC.getVisitBeforeFixing(visitID, categoryID),
    );

    return result.data ?? VisitBeforeFixingListModel();
  }
}
