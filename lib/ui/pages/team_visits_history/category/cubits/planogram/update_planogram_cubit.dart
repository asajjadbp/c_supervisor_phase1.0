import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../data/models/update_category/update_planogram_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdatePlanoGramCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdatePlanoGramCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updatePlanoGram({
    required UpdatePlanoGramModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updatePlanoGram(model),
    );
  }
}
