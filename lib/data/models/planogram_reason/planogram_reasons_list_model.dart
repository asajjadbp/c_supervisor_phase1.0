import 'package:c_supervisor/data/models/planogram_reason/planogram_reason_model.dart';
import 'package:networking/client/networking_models/index.dart';
class PlanoGramReasonListModel
    implements
        BaseNetworkSerializable,
        BaseNetworkDeserializable<PlanoGramReasonListModel> {
  PlanoGramReasonListModel({
    this.dataList,
  });

  List<PlanoGramReasonModel>? dataList;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataList != null) {
      map['dataList'] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  PlanoGramReasonListModel fromJson(Map<String, dynamic> json) {
    if (json['dataList'] != null) {
      dataList = [];
      json['dataList'].forEach((v) {
        dataList?.add(PlanoGramReasonModel().fromJson(v));
      });
    }

    return PlanoGramReasonListModel(dataList: dataList);
  }
}
