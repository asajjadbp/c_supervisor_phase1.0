import 'package:c_supervisor/data/models/visits_categories/visit_before_fixing_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class VisitBeforeFixingListModel extends BasePaginatedListModel<VisitBeforeFixingModel>
    implements BaseNetworkDeserializable<VisitBeforeFixingListModel> {
  VisitBeforeFixingListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  VisitBeforeFixingListModel fromJson(dynamic json) {
    return VisitBeforeFixingListModel(
      dataList: json['dataList'] == null
          ? []
          : List<VisitBeforeFixingModel>.from(
              json["dataList"].map((x) => VisitBeforeFixingModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
