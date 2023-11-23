import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdateRtvCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdateRtvCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updateRtv({
    required UpdateRtvModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updateRtv(model),
    );
  }
}
