import 'package:c_supervisor/data/models/visits_categories_list_model.dart';
import 'package:c_supervisor/domain/repositories/visits_categories_repo.dart';
import 'package:c_supervisor/ui/index.dart';

 class VisitsCategoriesUC {
  VisitsCategoriesRepo visitsCategoriesRepo;
  VisitsCategoriesUC(this.visitsCategoriesRepo);
  Future<BaseResponse<VisitsCategoriesListModel?>> getVisitsCategories({required int visitID}) {
    return visitsCategoriesRepo.getVisitsCategories(visitID);
  }
}
