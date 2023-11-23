import 'package:c_supervisor/domain/use_cases/clients_sku_uc.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../data/models/companies_brand_data_list_model.dart';
import '../../../bloc/base_app_cubit.dart';

class CompaniesBrandDataCubit
    extends BaseAppCubit<CompaniesBrandDataListModel> {
  final ClientsSkuUC clientsSkuUC;
  CompaniesBrandDataCubit(this.clientsSkuUC);

  Future<CompaniesBrandDataListModel> getCompaniesBrandData({
    required int companyID,
    required int langID,
  }) async {
    final BaseResponse<CompaniesBrandDataListModel?> result;

    result = await networkCall(
      () => clientsSkuUC.getCompaniesBrandData(
        companyID: companyID,
        langID: langID,
      ),
    );

    return result.data ?? CompaniesBrandDataListModel();
  }
}
