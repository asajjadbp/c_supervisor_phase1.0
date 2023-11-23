import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/data/models/my_coverage_list_model.dart';

import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../domain/repositories/my_coverage_repo.dart';
import '../data_sources/remote/application_remote_ds.dart';

class MyCoverageRepoImp implements MyCoverageRepo {
  ApplicationRemoteDS applicationRemoteDS;
  MyCoverageRepoImp(this.applicationRemoteDS);
  @override
  Future<BaseResponse<MyCoverageListModel?>> getMyCoverage({
    required FilterModel filterModel,
  }) async {
    return applicationRemoteDS.getMyCoverage(
      filterModel: filterModel,
    );
  }
}
