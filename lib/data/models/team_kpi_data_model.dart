import 'package:c_supervisor/data/models/common_data_model.dart';

class TeamKpiDataModel {
  TeamKpiDataModel({
    this.userName,
    this.id,
    this.fullName,
    this.imgUrl,
    this.kpiData,
  });

  TeamKpiDataModel.fromJson(dynamic json) {
    userName = json['userName'];
    id = json['id'];
    fullName = json['fullName'];
    imgUrl = json['imgUrl'];
    kpiData = KpiData.fromJson(json['kpiData']);
    proFeedBack = CommonDataModel().fromJson(json['proFeedBack']);
    effFeedBack = CommonDataModel().fromJson(json['effFeedBack']);
  }
  String? userName;
  int? id;
  String? fullName;
  String? imgUrl;
  // String? comment;
  KpiData? kpiData;
  CommonDataModel? proFeedBack;
  CommonDataModel? effFeedBack;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['id'] = id;
    map['fullName'] = fullName;
    //map['comment'] = comment;
    map['imgUrl'] = imgUrl;
    map['kpiData'] = kpiData?.toJson();
    map['proFeedBack'] = proFeedBack?.toJson();
    map['effFeedBack'] = effFeedBack?.toJson();
    return map;
  }
}

class KpiData {
  KpiData({
    this.att,
    this.eef,
    this.pro,
    this.jpc,
  });

  KpiData.fromJson(dynamic json) {
    att = json['att'];
    eef = json['eef'];
    pro = json['pro'];
    jpc = json['jpc'];
  }
  String? att;
  num? eef;
  num? pro;
  num? jpc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['att'] = att;
    map['eef'] = eef;
    map['pro'] = pro;
    map['jpc'] = jpc;
    return map;
  }
}
