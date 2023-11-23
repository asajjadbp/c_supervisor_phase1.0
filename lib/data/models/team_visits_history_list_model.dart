import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamVisitsHistoryListModel
    extends BasePaginatedListModel<TeamVisitsHistoryModel>
    implements BaseNetworkDeserializable<TeamVisitsHistoryListModel> {
  TeamVisitsHistoryListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  TeamVisitsHistoryListModel fromJson(dynamic json) {
    return TeamVisitsHistoryListModel(
      dataList: json['dataList'] == null
          ? []
          : List<TeamVisitsHistoryModel>.from(
              json["dataList"].map((x) => TeamVisitsHistoryModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
