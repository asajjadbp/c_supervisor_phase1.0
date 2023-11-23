import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

import 'chain_model.dart';

class ChainsListModel extends BasePaginatedListModel<ChainModel>
    implements BaseNetworkDeserializable<ChainsListModel> {
  ChainsListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  ChainsListModel fromJson(dynamic json) {
    return ChainsListModel(
      dataList: json['dataList'] == null
          ? []
          : List<ChainModel>.from(
          json["dataList"].map((x) => ChainModel.fromJson(x))),
    );
  }
}
