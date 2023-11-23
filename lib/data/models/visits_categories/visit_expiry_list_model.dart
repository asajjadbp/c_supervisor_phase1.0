import 'package:c_supervisor/data/models/visits_categories/visit_expiry_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class VisitExpiryListModel extends BasePaginatedListModel<VisitExpiryModel>
    implements BaseNetworkDeserializable<VisitExpiryListModel> {
  VisitExpiryListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  VisitExpiryListModel fromJson(dynamic json) {
    return VisitExpiryListModel(
      dataList: json['dataList'] == null
          ? []
          : List<VisitExpiryModel>.from(
              json["dataList"].map((x) => VisitExpiryModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
