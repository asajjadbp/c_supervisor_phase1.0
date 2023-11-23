import 'package:c_supervisor/data/models/index.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamListModel extends BasePaginatedListModel<TeamMemberModel>
    implements BaseNetworkDeserializable<TeamListModel> {
  TeamListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  TeamListModel fromJson(dynamic json) {
    return TeamListModel(
      dataList: json['dataList'] == null
          ? []
          : List<TeamMemberModel>.from(
              json["dataList"].map((x) => TeamMemberModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
