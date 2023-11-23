import 'package:c_supervisor/data/models/companies_brand_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_category_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_sku_data_list_model.dart';
import 'package:c_supervisor/domain/repositories/clients_sku_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../data_sources/remote/application_remote_ds.dart';

class ClientsSkuRepoImp implements ClientsSkuRepo {
  ApplicationRemoteDS applicationRemoteDS;
  ClientsSkuRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<CompaniesDataListModel?>> getCompaniesData({
    required int userID,
    required int langID,
  }) async {
    return applicationRemoteDS.getCompaniesData(userID: userID, langID: langID);
  }

  @override
  Future<BaseResponse<CompaniesSkuDataListModel?>> getCompaniesSkuData(
      {required int companyID, required int langID}) {
    return applicationRemoteDS.getCompaniesSkuData(
        companyID: companyID, langID: langID);
  }

  @override
  Future<BaseResponse<CompaniesCategoryDataListModel?>>
      getCompaniesCategoryData(
          {required int companyID, required int langID}) async {
    return applicationRemoteDS.getCompaniesCategoryData(
        companyID: companyID, langID: langID);
  }

  @override
  Future<BaseResponse<CompaniesBrandDataListModel?>> getCompaniesBrandData(
      {required int companyID, required int langID}) async {
    return applicationRemoteDS.getCompaniesBrandData(
        companyID: companyID, langID: langID);
  }
}
