import 'package:c_supervisor/data/models/team_filter_result_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamFilterListModel extends BasePaginatedListModel<TeamFilterResultModel>
    implements BaseNetworkDeserializable<TeamFilterListModel> {
  TeamFilterListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  TeamFilterListModel fromJson(dynamic json) {
    return TeamFilterListModel(
      dataList: json['dataList'] == null
          ? []
          : List<TeamFilterResultModel>.from(
              json["dataList"].map((x) => TeamFilterResultModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
