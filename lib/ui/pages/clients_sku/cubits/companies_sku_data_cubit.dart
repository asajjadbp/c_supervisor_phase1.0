import 'package:c_supervisor/domain/use_cases/clients_sku_uc.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../data/models/companies_sku_data_list_model.dart';
import '../../../bloc/base_app_cubit.dart';

class CompaniesSkuDataCubit
    extends BaseAppCubit<CompaniesSkuDataListModel> {
  final ClientsSkuUC clientsSkuUC;
  CompaniesSkuDataCubit(this.clientsSkuUC);

  Future<CompaniesSkuDataListModel> getCompaniesSkuData({
    required int companyID,
    required int langID,
  }) async {
    final BaseResponse<CompaniesSkuDataListModel?> result;

    result = await networkCall(
          () => clientsSkuUC.getCompaniesSkuData(
        companyID: companyID,
        langID: langID,
      ),
    );

    return result.data ?? CompaniesSkuDataListModel();
  }
}
