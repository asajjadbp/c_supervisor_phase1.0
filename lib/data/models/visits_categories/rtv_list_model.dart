import 'package:c_supervisor/data/models/visits_categories/rtv_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class RTVListModel extends BasePaginatedListModel<RTVModel>
    implements BaseNetworkDeserializable<RTVListModel> {
  RTVListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  RTVListModel fromJson(dynamic json) {
    return RTVListModel(
      dataList: json['dataList'] == null
          ? []
          : List<RTVModel>.from(
              json["dataList"].map((x) => RTVModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
