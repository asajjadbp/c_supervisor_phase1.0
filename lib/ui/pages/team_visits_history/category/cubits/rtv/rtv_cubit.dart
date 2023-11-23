import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/visits_categories/rtv_list_model.dart';
import '../../../../../../domain/use_cases/visits_categories/rtv_uc.dart';

class RTVCubit extends BaseAppCubit<RTVListModel> {
  final RtvUC rtvUC;
  final int visitID;
  final int categoryID;
  RTVCubit({
    required this.rtvUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<RTVListModel> loadItemsAtPage() async {
    final BaseResponse<RTVListModel?> result;

    result = await networkCall(
      () => rtvUC.getRTV(visitID, categoryID),
    );

    return result.data ?? RTVListModel();
  }
}
