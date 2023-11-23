import 'package:c_supervisor/domain/use_cases/update_category/update_category_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';

import '../../../../../../data/models/planogram_reason/planogram_reasons_list_model.dart';

class PlanoGramReasonsCubit extends BaseAppCubit<PlanoGramReasonListModel> {
  final UpdateCategoryUC updateCategoryUC;
  PlanoGramReasonsCubit(this.updateCategoryUC);

  Future<PlanoGramReasonListModel> getPlanoGramReasonsList() async {
    final BaseResponse<PlanoGramReasonListModel?> result;

    result = await networkCall(
      () => updateCategoryUC.getPlanoGramReasonsList(),
    );

    return result.data ?? PlanoGramReasonListModel();
  }
}
