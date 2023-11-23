import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/visits_categories/visit_expiry_list_model.dart';
import '../../../../../../domain/use_cases/visits_categories/visit_expiry_uc.dart';

class VisitExpiryCubit extends BaseAppCubit<VisitExpiryListModel> {
  final VisitExpiryUC visitExpiryUC;
  final int visitID;
  final int categoryID;
  VisitExpiryCubit({
    required this.visitExpiryUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<VisitExpiryListModel> loadItemsAtPage() async {
    final BaseResponse<VisitExpiryListModel?> result;

    result = await networkCall(
      () => visitExpiryUC.getVisitExpiry(visitID, categoryID),
    );

    return result.data ?? VisitExpiryListModel();
  }
}
