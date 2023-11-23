import 'package:c_supervisor/data/models/visits_categories/visit_price_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class VisitPriceListModel extends BasePaginatedListModel<VisitPriceModel>
    implements BaseNetworkDeserializable<VisitPriceListModel> {
  VisitPriceListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  VisitPriceListModel fromJson(dynamic json) {
    return VisitPriceListModel(
      dataList: json['dataList'] == null
          ? []
          : List<VisitPriceModel>.from(
              json["dataList"].map((x) => VisitPriceModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
