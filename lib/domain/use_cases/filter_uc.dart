import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';


class FilterUC {
  final FilterRepo filterRepo;

  FilterUC(this.filterRepo);

  Future<BaseResponse<TeamFilterListModel?>> getTeamSearchFilter(
      FilterByNameModel filterModel) {
    return filterRepo.getTeamSearchFilter(filterModel);
  }

  Future<BaseResponse<TeamRolesListModel?>> getRolesSearchFilter() {
    return filterRepo.getRolesSearchFilter();
  }
}
