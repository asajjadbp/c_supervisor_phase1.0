import 'package:c_supervisor/data/models/common_data_model.dart';
import 'package:networking/client/networking_models/index.dart';
class CommonDataListModel
    implements
        BaseNetworkSerializable,
        BaseNetworkDeserializable<CommonDataListModel> {
  CommonDataListModel({
    this.dataList,
  });

  List<CommonDataModel>? dataList;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataList != null) {
      map['dataList'] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  CommonDataListModel fromJson(Map<String, dynamic> json) {
    if (json['dataList'] != null) {
      dataList = [];
      json['dataList'].forEach((v) {
        dataList?.add(CommonDataModel().fromJson(v));
      });
    }

    return CommonDataListModel(dataList: dataList);
  }
}
