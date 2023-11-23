import 'package:c_supervisor/data/models/knowledge_base_categories_list_model.dart';
import 'package:c_supervisor/domain/use_cases/knowledge_share_uc.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';


class KnowledgeBaseCategoriesCubit
    extends BaseAppCubit<KnowledgeBaseCategoriesListModel> {
  final KnowledgeShareUC knowledgeShareUC;

  KnowledgeBaseCategoriesCubit(this.knowledgeShareUC);

  Future<KnowledgeBaseCategoriesListModel> getKnowledgeBaseCategories() async {
    final BaseResponse<KnowledgeBaseCategoriesListModel?> result;

    result = await networkCall(
      () => knowledgeShareUC.getKnowledgeBaseCategories(),
    );

    return result.data ?? KnowledgeBaseCategoriesListModel();
  }
}
