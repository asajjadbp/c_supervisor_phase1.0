import 'package:c_supervisor/data/models/sup_visits/sup_visits_list_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/sup_visits_to_json.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/utilities/mixins/user_info_mixin.dart';

import '../../../index.dart';
import '../../team_kpi/index.dart';

class MyJPCubit extends BaseAppPagingCubit<SupVisitsListModel>
    with UserInfoMixin {
  final SupVisitsUC supVisitsUC;

  MyJPCubit({
    required this.supVisitsUC,
  });

  @override
  Future<SupVisitsListModel> loadItemsAtPage(int page, {args}) async {
    final BaseResponse<SupVisitsListModel?> result;
    result = await networkCall(
      () => supVisitsUC.getSupVisits(
        model: SupVisitsToJsonModel(
          pageNumber: page,
          userID: getUserId(),
          pageSize: 20,
        ),
      ),
    );

    return result.data ?? SupVisitsListModel();
  }
}
