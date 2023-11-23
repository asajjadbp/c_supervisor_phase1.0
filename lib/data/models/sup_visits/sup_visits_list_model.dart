import 'package:c_supervisor/data/models/sup_visits/sup_visits_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class SupVisitsListModel extends BasePaginatedListModel<SupVisitsModel>
    implements BaseNetworkDeserializable<SupVisitsListModel> {
  SupVisitsListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  SupVisitsListModel fromJson(dynamic json) {
    return SupVisitsListModel(
      dataList: json['dataList'] == null
          ? []
          : List<SupVisitsModel>.from(
              json["dataList"].map((x) => SupVisitsModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
