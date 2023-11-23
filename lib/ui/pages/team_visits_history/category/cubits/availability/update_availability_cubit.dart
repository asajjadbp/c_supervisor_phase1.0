import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../data/models/update_category/update_availability_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdateAvailabilityCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdateAvailabilityCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updateAvailability({
    required UpdateAvailabilityModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updateAvailability(model),
    );
  }
}
