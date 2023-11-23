import 'package:c_supervisor/data/index.dart';
import 'package:c_supervisor/domain/use_cases/filter_methods_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';

import '../../../../data/models/chains_list_model.dart';

class ChainsCubit extends BaseAppPagingCubit<ChainsListModel> {
  final FilterMethodsUC filterMethodsUC;
  ChainsCubit(this.filterMethodsUC);

  @override
  Future<ChainsListModel> loadItemsAtPage(int page, {args}) async {
    final BaseResponse<ChainsListModel?> result;

    result = await networkCall(
      () => filterMethodsUC.getChains(
        landID: 1,
        userID: 7,
        pageSize: APIEndpoints.pageSize,
        pageNumber: page,
      ),
    );

    return result.data ?? ChainsListModel();
  }
}
