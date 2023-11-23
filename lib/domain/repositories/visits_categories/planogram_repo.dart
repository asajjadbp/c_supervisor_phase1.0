import 'package:c_supervisor/data/models/visits_categories/planogram_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

abstract class PlanoGramRepo {
  Future<BaseResponse<PlanoGramListModel?>> getPlanoGram({
    required int visitID,
    required int categoryID,
  });
}
