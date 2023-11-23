import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class FilterRepo {
  Future<BaseResponse<TeamFilterListModel?>> getTeamSearchFilter(
      FilterByNameModel filterModel);
  Future<BaseResponse<TeamRolesListModel?>> getRolesSearchFilter();
}
