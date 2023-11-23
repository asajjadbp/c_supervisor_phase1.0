import 'package:c_supervisor/data/models/visits_categories/visit_stock_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class VisitStockListModel extends BasePaginatedListModel<VisitStockModel>
    implements BaseNetworkDeserializable<VisitStockListModel> {
  VisitStockListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  VisitStockListModel fromJson(dynamic json) {
    return VisitStockListModel(
      dataList: json['dataList'] == null
          ? []
          : List<VisitStockModel>.from(
              json["dataList"].map((x) => VisitStockModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
