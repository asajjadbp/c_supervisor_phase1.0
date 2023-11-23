import 'package:c_supervisor/data/models/team_role_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamRolesListModel extends BasePaginatedListModel<TeamRoleModel>
    implements BaseNetworkDeserializable<TeamRolesListModel> {
  TeamRolesListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  TeamRolesListModel fromJson(dynamic json) {
    return TeamRolesListModel(
      dataList: json['dataList'] == null
          ? []
          : List<TeamRoleModel>.from(
              json["dataList"].map((x) => TeamRoleModel().fromJson(x))),
      //totalCount: json['totalCount'],
    );
  }
}
