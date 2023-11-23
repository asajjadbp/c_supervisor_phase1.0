import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/my_coverage_list_model.dart';
import '../repositories/my_coverage_repo.dart';

class MyCoverageUC {
  MyCoverageRepo myCoverageRepo;
  MyCoverageUC(this.myCoverageRepo);

  Future<BaseResponse<MyCoverageListModel?>> getMyCoverage({

required FilterModel filterModel,
  }) {
    return myCoverageRepo.getMyCoverage(
      filterModel: filterModel,
    );
  }
}
