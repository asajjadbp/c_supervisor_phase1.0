import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/data/models/my_coverage_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

abstract class MyCoverageRepo {
  Future<BaseResponse<MyCoverageListModel?>> getMyCoverage({
    required FilterModel filterModel,
  });
}
