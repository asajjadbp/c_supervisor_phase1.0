import 'package:c_supervisor/data/models/visits_categories/sos_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class SOSListModel extends BasePaginatedListModel<SOSModel>
    implements BaseNetworkDeserializable<SOSListModel> {
  SOSListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  SOSListModel fromJson(dynamic json) {
    return SOSListModel(
      dataList: json['dataList2'] == null
          ? []
          : List<SOSModel>.from(
              json["dataList2"].map((x) => SOSModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
