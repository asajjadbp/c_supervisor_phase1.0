import 'package:c_supervisor/data/models/my_coverage_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';
class MyCoverageListModel extends BasePaginatedListModel<MyCoverageModel>
    implements BaseNetworkDeserializable<MyCoverageListModel> {
  MyCoverageListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  MyCoverageListModel fromJson(dynamic json) {
    return MyCoverageListModel(
      dataList: json['dataList'] == null
          ? []
          : List<MyCoverageModel>.from(
              json["dataList"].map((x) => MyCoverageModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
