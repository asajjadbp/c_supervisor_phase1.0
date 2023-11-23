import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/update_category/update_sos_model.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdateSOSCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdateSOSCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updateSOS({
    required UpdateSOSModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updateSOS(model),
    );
  }
}
