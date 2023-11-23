import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class CancelAvailabilityCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  CancelAvailabilityCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> cancelUpdateAvailability({
    required int id,
    required int userId,
  }) async {
    return await networkCall(
      () => updateCategoryUC.cancelUpdateAvailability(
        id: id,
        userId: userId,
      ),
    );
  }
}
