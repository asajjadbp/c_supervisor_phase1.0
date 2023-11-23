import 'package:c_supervisor/data/models/sup_visits/modules/check_list/checklist_list_model.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import '../../../../../bloc/base_app_cubit.dart';

class CheckListCubit extends BaseAppCubit<CheckListListModel> {
  final SupVisitsUC supVisitsUC;

  CheckListCubit({
    required this.supVisitsUC,
  });

  Future<CheckListListModel> getCheckList({
    required int visitId,
  }) async {
    final BaseResponse<CheckListListModel?> result;
    result = await networkCall(
      () => supVisitsUC.getCheckList(visitId: visitId),
    );

    return result.data ?? CheckListListModel();
  }
}
