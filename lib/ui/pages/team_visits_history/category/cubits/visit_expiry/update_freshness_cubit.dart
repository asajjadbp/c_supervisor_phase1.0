import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../data/models/update_category/update_freshness_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdateFreshnessCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdateFreshnessCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updateFreshness({
    required UpdateFreshnessModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updateFreshness(model),
    );
  }
}
