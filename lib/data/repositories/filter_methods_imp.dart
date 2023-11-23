import 'package:c_supervisor/data/data_sources/remote/application_remote_ds.dart';
import 'package:c_supervisor/data/models/chains_list_model.dart';
import 'package:c_supervisor/data/models/city_list_model.dart';
import 'package:c_supervisor/data/models/company_list_model.dart';
import 'package:c_supervisor/data/models/region_list_model.dart';

import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../domain/repositories/filter_methods_repo.dart';

class FilterMethodsRepoImp implements FilterMethodsRepo {
  ApplicationRemoteDS applicationRemoteDS;
  FilterMethodsRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<CitiesListModel?>> getCities({
    required int userID,
    required int langID,
  }) async {
    return applicationRemoteDS.getCities(userID: userID, langID: langID);
  }

  @override
  Future<BaseResponse<ChainsListModel?>> getChains({
    required int pageNumber,
    required int pageSize,
    required int userID,
    // required String? chainID,
    // required String? channelId,
    // required String? companyId,
    required int landID,
  }) async {
    return applicationRemoteDS.getChains(
      pageNumber: pageNumber,
      pageSize: pageSize,
      userID: userID,
      // chainID: chainID,
      // channelId: channelId,
      // companyId: companyId,
      landID: landID,
    );
  }

  @override
  Future<BaseResponse<RegionsListModel?>> getRegions(
      {required int userID, required int langID}) async {
    return applicationRemoteDS.getRegions(userID: userID, langID: langID);
  }

  @override
  Future<BaseResponse<CompanyListModel?>> getCompanies(
      {required int userID, required int langID}) async {
    return applicationRemoteDS.getCompanies(userID: userID, langID: langID);
  }
}
