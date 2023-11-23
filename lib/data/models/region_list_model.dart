import 'package:c_supervisor/data/models/region_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class RegionsListModel extends BasePaginatedListModel<RegionModel>
    implements BaseNetworkDeserializable<RegionsListModel> {
  RegionsListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  RegionsListModel fromJson(dynamic json) {
    return RegionsListModel(
      dataList: json['dataList'] == null
          ? []
          : List<RegionModel>.from(
              json["dataList"].map((x) => RegionModel.fromJson(x))),
    );
  }
}
