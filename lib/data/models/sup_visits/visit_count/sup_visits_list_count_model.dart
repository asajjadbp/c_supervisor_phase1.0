import 'package:c_supervisor/data/models/sup_visits/visit_count/sup_visits_count_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class SupVisitsCountListModel
    extends BasePaginatedListModel<SupVisitsCountModel>
    implements BaseNetworkDeserializable<SupVisitsCountListModel> {
  SupVisitsCountListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  SupVisitsCountListModel fromJson(dynamic json) {
    return SupVisitsCountListModel(
      dataList: json['dataList'] == null
          ? []
          : List<SupVisitsCountModel>.from(
              json["dataList"].map((x) => SupVisitsCountModel.fromJson(x))),
      totalCount: json['totalCount'] ?? 0,
    );
  }
}
