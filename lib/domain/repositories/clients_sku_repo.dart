import 'package:c_supervisor/data/models/companies_category_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_data_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/companies_brand_data_list_model.dart';
import '../../data/models/companies_sku_data_list_model.dart';

abstract class ClientsSkuRepo {
  Future<BaseResponse<CompaniesDataListModel?>> getCompaniesData({
    required int userID,
    required int langID,
  });
  Future<BaseResponse<CompaniesSkuDataListModel?>> getCompaniesSkuData({
    required int companyID,
    required int langID,
  });
  Future<BaseResponse<CompaniesCategoryDataListModel?>> getCompaniesCategoryData({
    required int companyID,
    required int langID,
  });
  Future<BaseResponse<CompaniesBrandDataListModel?>> getCompaniesBrandData({
    required int companyID,
    required int langID,
  });
}
