import 'package:c_supervisor/data/models/index.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamKPIListModel extends BasePaginatedListModel<TeamKpiDataModel>
    implements BaseNetworkDeserializable<TeamKPIListModel> {
  TeamKPIListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  TeamKPIListModel fromJson(dynamic json) {
    return TeamKPIListModel(
      dataList: json['dataList'] == null
          ? []
          : List<TeamKpiDataModel>.from(
              json["dataList"].map((x) => TeamKpiDataModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
