import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

import 'availability_model.dart';
class AvailabilityListModel extends BasePaginatedListModel<AvailabilityModel>
    implements BaseNetworkDeserializable<AvailabilityListModel> {
  AvailabilityListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  AvailabilityListModel fromJson(dynamic json) {
    return AvailabilityListModel(
      dataList: json['dataList'] == null
          ? []
          : List<AvailabilityModel>.from(
          json["dataList"].map((x) => AvailabilityModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
