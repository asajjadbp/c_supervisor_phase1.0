import 'package:c_supervisor/data/models/visits_categories/planogram_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class PlanoGramListModel extends BasePaginatedListModel<PlanoGramModel>
    implements BaseNetworkDeserializable<PlanoGramListModel> {
  PlanoGramListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  PlanoGramListModel fromJson(dynamic json) {
    return PlanoGramListModel(
      dataList: json['dataList'] == null
          ? []
          : List<PlanoGramModel>.from(
              json["dataList"].map((x) => PlanoGramModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
