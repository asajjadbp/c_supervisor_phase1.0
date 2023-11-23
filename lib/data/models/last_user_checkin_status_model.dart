import '../../ui/index.dart';

class LastUserCheckInStatusModel implements BaseNetworkDeserializable {
  LastUserCheckInStatusModel({
    this.dataList,
  });

  DataList? dataList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dataList'] = dataList;
    return map;
  }

  @override
  LastUserCheckInStatusModel fromJson(Map<String, dynamic> json) {
    dataList = DataList.fromJson(json['dataList']);
    return LastUserCheckInStatusModel(dataList: dataList);
  }
}

class DataList {
  DataList({
    this.checkedIn,
  });

  bool? checkedIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['checkedIn'] = checkedIn;
    return map;
  }

  DataList.fromJson(Map<String, dynamic> json) {
    checkedIn = json['checkedIn'];
  }
}
