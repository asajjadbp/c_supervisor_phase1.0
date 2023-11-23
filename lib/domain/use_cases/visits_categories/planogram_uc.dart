import 'package:c_supervisor/data/models/visits_categories/planogram_list_model.dart';
import 'package:c_supervisor/domain/repositories/visits_categories/planogram_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

class PlanoGramUC {
  PlanoGramRepo planoGramRepo;
  PlanoGramUC(this.planoGramRepo);
  Future<BaseResponse<PlanoGramListModel?>> getPlanoGram(
      int visitID, int categoryID) {
    return planoGramRepo.getPlanoGram(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
