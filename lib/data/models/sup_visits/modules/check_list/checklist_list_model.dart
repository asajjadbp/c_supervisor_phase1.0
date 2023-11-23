import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

import 'checklist_model.dart';

class CheckListListModel extends BasePaginatedListModel<CheckListModel>
    implements BaseNetworkDeserializable<CheckListListModel> {
  CheckListListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CheckListListModel fromJson(dynamic json) {
    return CheckListListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CheckListModel>.from(
              json["dataList"].map((x) => CheckListModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
