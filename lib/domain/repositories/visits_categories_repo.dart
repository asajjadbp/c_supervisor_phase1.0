import 'package:c_supervisor/data/models/visits_categories_list_model.dart';
import 'package:c_supervisor/ui/index.dart';

abstract class VisitsCategoriesRepo {
  Future<BaseResponse<VisitsCategoriesListModel?>> getVisitsCategories(
      int visitID);
}
