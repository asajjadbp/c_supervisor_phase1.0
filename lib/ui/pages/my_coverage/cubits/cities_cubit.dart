import 'package:c_supervisor/data/models/city_list_model.dart';
import 'package:c_supervisor/domain/use_cases/filter_methods_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';

import '../../../bloc/base_app_cubit.dart';

class CitiesCubit extends BaseAppCubit<CitiesListModel> {
  final FilterMethodsUC filterMethodsUC;
  CitiesCubit(this.filterMethodsUC);
  Future<CitiesListModel> loadItemsAtPage() async {
    final BaseResponse<CitiesListModel?> result;

    result = await networkCall(
      () => filterMethodsUC.getCities(userID: 7, langID: 1),
    );

    return result.data ?? CitiesListModel();
  }
}
