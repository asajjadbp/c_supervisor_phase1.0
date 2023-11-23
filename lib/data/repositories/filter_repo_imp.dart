import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/filter_by_name_model.dart';
import 'package:c_supervisor/data/models/team_filter_list_model.dart';
import 'package:c_supervisor/data/models/team_role_list_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class FilterRepoImp implements FilterRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  FilterRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<TeamFilterListModel?>> getTeamSearchFilter(
      FilterByNameModel filterModel) {
    return applicationRemoteDS.getTeamSearchFilter(filterModel);
  }

  @override
  Future<BaseResponse<TeamRolesListModel?>> getRolesSearchFilter() {
    return applicationRemoteDS.getRolesSearchFilter();
  }
}
