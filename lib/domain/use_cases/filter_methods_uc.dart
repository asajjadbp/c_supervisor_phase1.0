import 'package:c_supervisor/domain/repositories/filter_methods_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/chains_list_model.dart';
import '../../data/models/city_list_model.dart';
import '../../data/models/company_list_model.dart';
import '../../data/models/region_list_model.dart';

class FilterMethodsUC {
  final FilterMethodsRepo filterMethodsRepo;

  FilterMethodsUC(this.filterMethodsRepo);

  Future<BaseResponse<CitiesListModel?>> getCities({
    required int userID,
    required int langID,
  }) {
    return filterMethodsRepo.getCities(userID: userID, langID: langID);
  }

  Future<BaseResponse<RegionsListModel?>> getRegions({
    required int userID,
    required int langID,
  }) {
    return filterMethodsRepo.getRegions(userID: userID, langID: langID);
  }

  Future<BaseResponse<CompanyListModel?>> getCompanies({
    required int userID,
    required int langID,
  }) {
    return filterMethodsRepo.getCompanies(userID: userID, langID: langID);
  }

  Future<BaseResponse<ChainsListModel?>> getChains({
    required int pageNumber,
    required int pageSize,
    required int userID,
    // String? chainID,
    // String? channelId,
    // String? companyId,
    required int landID,
  }) {
    return filterMethodsRepo.getChains(
      pageNumber: pageNumber,
      pageSize: pageSize,
      userID: userID,
      // chainID: chainID,
      // channelId: channelId,
      // companyId: companyId,
      landID: landID,
    );
  }
}
