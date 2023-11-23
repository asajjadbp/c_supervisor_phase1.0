import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../../data/models/update_category/update_stock_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';

class UpdateVisitStockCubit extends BaseAppCubit<EmptyModel?> {
  final UpdateCategoryUC updateCategoryUC;

  UpdateVisitStockCubit({required this.updateCategoryUC});

  Future<BaseResponse<EmptyModel?>> updateVisitStock({
    required UpdateStockModel model,
  }) async {
    return await networkCall(
      () => updateCategoryUC.updateVisitStock(model),
    );
  }
}
