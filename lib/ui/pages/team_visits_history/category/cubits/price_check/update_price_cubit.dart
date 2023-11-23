import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../data/models/update_category/update_price_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdatePriceCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdatePriceCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updatePriceCheck({
    required UpdatePriceModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updatePriceCheck(model),
    );
  }
}
