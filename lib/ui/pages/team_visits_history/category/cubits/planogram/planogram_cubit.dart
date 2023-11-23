import 'package:c_supervisor/data/models/visits_categories/planogram_list_model.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories/planogram_uc.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

class PlanoGramCubit extends BaseAppCubit<PlanoGramListModel> {
  final PlanoGramUC planoGramUC;
  final int visitID;
  final int categoryID;
  PlanoGramCubit({
    required this.planoGramUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<PlanoGramListModel> loadItemsAtPage() async {
    final BaseResponse<PlanoGramListModel?> result;

    result = await networkCall(
      () => planoGramUC.getPlanoGram(visitID, categoryID),
    );

    return result.data ?? PlanoGramListModel();
  }
}
