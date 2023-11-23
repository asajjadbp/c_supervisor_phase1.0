import 'package:c_supervisor/domain/use_cases/clients_sku_uc.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../data/models/companies_category_data_list_model.dart';
import '../../../bloc/base_app_cubit.dart';

class CompaniesCategoryDataCubit
    extends BaseAppCubit<CompaniesCategoryDataListModel> {
  final ClientsSkuUC clientsSkuUC;
  CompaniesCategoryDataCubit(this.clientsSkuUC);

  Future<CompaniesCategoryDataListModel> getCompaniesCategoryData({
    required int companyID,
    required int langID,
  }) async {
    final BaseResponse<CompaniesCategoryDataListModel?> result;

    result = await networkCall(
      () => clientsSkuUC.getCompaniesCategoryData(
        companyID: companyID,
        langID: langID,
      ),
    );

    return result.data ?? CompaniesCategoryDataListModel();
  }
}
