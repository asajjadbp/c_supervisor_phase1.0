import 'package:c_supervisor/data/models/companies_data_list_model.dart';
import 'package:c_supervisor/domain/use_cases/clients_sku_uc.dart';
import 'package:get_it/get_it.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../data/data_sources/local/app_shared_prefs_client.dart';
import '../../../bloc/base_app_cubit.dart';

class CompaniesDataCubit extends BaseAppCubit<CompaniesDataListModel> {
  final ClientsSkuUC clientsSkuUC;
  CompaniesDataCubit(this.clientsSkuUC);


  Future<CompaniesDataListModel> loadItemsAtPage() async {
    final BaseResponse<CompaniesDataListModel?> result;
    final userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    const int langID = 1;

    result = await networkCall(
      () => clientsSkuUC.getCompaniesData(
        userID: userID,
        langID: langID,
      ),
    );

    return result.data ?? CompaniesDataListModel();
  }
}
