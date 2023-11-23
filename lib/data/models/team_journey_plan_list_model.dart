import 'package:c_supervisor/data/models/team_journey_plan_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamJourneyPlanListModel
    extends BasePaginatedListModel<TeamJourneyPlanModel>
    implements BaseNetworkDeserializable<TeamJourneyPlanListModel> {
  TeamJourneyPlanListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  TeamJourneyPlanListModel fromJson(dynamic json) {
    return TeamJourneyPlanListModel(
      dataList: json['dataList'] == null
          ? []
          : List<TeamJourneyPlanModel>.from(
              json["dataList"].map((x) => TeamJourneyPlanModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
