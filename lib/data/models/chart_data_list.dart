import 'package:networking/client/networking_models/index.dart';

import 'chart_data_model.dart';

class ChartDataList implements BaseNetworkDeserializable<ChartDataList> {
  ChartDataList({
    this.dataList,
  });

  List<ChartDataModel>? dataList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataList != null) {
      map['dataList'] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  ChartDataList fromJson(Map<String, dynamic> json) {
    if (json['dataList'] != null) {
      dataList = [];
      json['dataList'].forEach((v) {
        dataList?.add(ChartDataModel.fromJson(v));
      });
    }
    return ChartDataList(dataList: dataList);
  }
}
