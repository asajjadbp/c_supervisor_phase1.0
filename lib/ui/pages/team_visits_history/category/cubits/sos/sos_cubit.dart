import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/visits_categories/sos_list_model.dart';
import '../../../../../../domain/use_cases/visits_categories/sos_uc.dart';

class SOSCubit extends BaseAppCubit<SOSListModel> {
  final SosUC sosUC;
  final int visitID;
  final int categoryID;
  SOSCubit({
    required this.sosUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<SOSListModel> loadItemsAtPage() async {
    final BaseResponse<SOSListModel?> result;

    result = await networkCall(
      () => sosUC.getSOS(visitID, categoryID),
    );

    return result.data ?? SOSListModel();
  }
}
