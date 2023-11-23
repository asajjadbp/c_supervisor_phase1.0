import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/chains_list_model.dart';
import '../../data/models/city_list_model.dart';
import '../../data/models/company_list_model.dart';
import '../../data/models/region_list_model.dart';

/// This class contains of all methods that can be used for filtering on all app
/// for example:
/// in my coverage screen i want to filter using [Chains,Cities]
/// then i am using functions [getChains] and [getCities]
abstract class FilterMethodsRepo {
  Future<BaseResponse<ChainsListModel?>> getChains({
    required int pageNumber,
    required int pageSize,
    required int userID,
    required int landID,
  });
  Future<BaseResponse<CitiesListModel?>> getCities({
    required int userID,
    required int langID,
  });
  Future<BaseResponse<RegionsListModel?>> getRegions({
    required int userID,
    required int langID,
  });
  Future<BaseResponse<CompanyListModel?>> getCompanies({
    required int userID,
    required int langID,
  });
}
