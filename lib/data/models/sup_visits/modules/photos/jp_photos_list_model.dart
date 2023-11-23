import 'package:c_supervisor/data/models/sup_visits/modules/photos/jp_photos_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class JPPhotosListModel extends BasePaginatedListModel<JPPhotosModel>
    implements BaseNetworkDeserializable<JPPhotosListModel> {
  JPPhotosListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  JPPhotosListModel fromJson(dynamic json) {
    return JPPhotosListModel(
      dataList: json['dataList'] == null
          ? []
          : List<JPPhotosModel>.from(
              json["dataList"].map((x) => JPPhotosModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
