import 'package:c_supervisor/data/models/companies_data_list_model.dart';
import 'package:c_supervisor/domain/repositories/clients_sku_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/companies_brand_data_list_model.dart';
import '../../data/models/companies_category_data_list_model.dart';
import '../../data/models/companies_sku_data_list_model.dart';

class ClientsSkuUC {
  ClientsSkuRepo clientsSkuRepo;
  ClientsSkuUC(this.clientsSkuRepo);
  Future<BaseResponse<CompaniesDataListModel?>> getCompaniesData({
    required int userID,
    required int langID,
  }) {
    return clientsSkuRepo.getCompaniesData(userID: userID,langID: langID);
  }
  Future<BaseResponse<CompaniesSkuDataListModel?>> getCompaniesSkuData({
    required int companyID,
    required int langID,
  }) {
    return clientsSkuRepo.getCompaniesSkuData(companyID: companyID,langID: langID);
  }
  Future<BaseResponse<CompaniesCategoryDataListModel?>> getCompaniesCategoryData({
    required int companyID,
    required int langID,
  }) {
    return clientsSkuRepo.getCompaniesCategoryData(companyID: companyID,langID: langID);
  }
  Future<BaseResponse<CompaniesBrandDataListModel?>> getCompaniesBrandData({
    required int companyID,
    required int langID,
  }) {
    return clientsSkuRepo.getCompaniesBrandData(companyID: companyID,langID: langID);
  }
}
