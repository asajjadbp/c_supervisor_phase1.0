import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class ConfirmAvailabilityCubit
    extends BaseAppCubit<ConfirmSuccessResponseModel?> {
  final UpdateCategoryUC updateCategoryUC;

  ConfirmAvailabilityCubit({required this.updateCategoryUC});

  Future<BaseResponse<ConfirmSuccessResponseModel?>> confirmUpdateAvailability({
    required int id,
    required int userId,
  }) async {
    return await networkCall(
      () => updateCategoryUC.confirmUpdateAvailability(
        id: id,
        userId: userId,
      ),
    );
  }
}
