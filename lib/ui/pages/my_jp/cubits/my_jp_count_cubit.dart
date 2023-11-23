import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/utilities/mixins/user_info_mixin.dart';

import '../../../../data/models/sup_visits/visit_count/sup_visits_list_count_model.dart';
import '../../team_kpi/index.dart';

class MyJPCountCubit extends BaseAppCubit<SupVisitsCountListModel>
    with UserInfoMixin {
  final SupVisitsUC supVisitsUC;

  MyJPCountCubit({
    required this.supVisitsUC,
  });

  Future<SupVisitsCountListModel> getSupVisitsCount({
    required int userId,
  }) async {
    final BaseResponse<SupVisitsCountListModel?> result;
    result = await networkCall(
      () => supVisitsUC.getSupVisitsCount(
        userId: userId,
      ),
    );

    return result.data ?? SupVisitsCountListModel();
  }
}
