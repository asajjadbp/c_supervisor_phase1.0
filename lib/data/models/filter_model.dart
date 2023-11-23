import 'package:networking/client/networking_models/index.dart';

/// pageNumber : 1
/// pageSize : 20
/// childIDs : []
/// startDate : "2022-11-17T12:45:11.921Z"
/// endDate : "2022-11-17T12:45:11.921Z"
/// userID : 69

class FilterModel implements BaseNetworkSerializable<FilterModel> {
  FilterModel({
    this.pageNumber,
    this.pageSize,
    this.childsIDs,
    this.roleIDs,
    this.startDate,
    this.endDate,
    this.userID,
    this.searchWord,
    this.companyId,
    this.chainIDs,
    this.cityIDs,
    this.status,
    this.companyIDs,
    this.regionIDs,
    this.visitEndDate,
    this.visitStartDate,
    this.visitsDate,
  });

  int? pageNumber;
  int? pageSize;
  List<int>? childsIDs;
  List<int>? companyIDs;
  List<int>? regionIDs;
  List<int>? roleIDs;
  String? startDate;
  String? visitStartDate;
  String? visitEndDate;
  String? visitsDate;
  String? endDate;
  String? searchWord;
  int? userID;
  int? status;
  int? companyId;
  List<int>? chainIDs;
  List<int>? cityIDs;
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['childIDs'] = childsIDs;
    map['roleIDs'] = [];
    if (roleIDs != null) {
      map['roleIDs'] = roleIDs?.map((v) => v.toInt()).toList();
    } else {
      map['roleIDs'] = [];
    }
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['userID'] = userID;
    map['status'] = status ?? 0;
    return map;
  }

  Map<String, dynamic> toMyCoverage() {
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['userID'] = userID;
    map['companyId'] = companyId ?? 1;
    map['chainIDs'] = chainIDs ?? [];
    map['cityIDs'] = cityIDs ?? [];
    map['searchWord'] = searchWord ?? "";

    return map;
  }

  Map<String, dynamic> toVisitHistoryJson() {
    ///todo const data
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['userID'] = userID;
    map['visitStartDate'] = "2023-8-15";
    map['visitEndDate'] = "2023-8-15";
    map['childsIDs'] = childsIDs ?? [];
    map['companyIDs'] = companyIDs ?? [];
    map['cityIDs'] = cityIDs ?? [];
    map['regionIDs'] = regionIDs ?? [];

    return map;
  }

  Map<String, dynamic> toTeamJPJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['chainIDs'] = chainIDs ?? [];
    map['cityIDs'] = cityIDs ?? [];
    map['regionIDs'] = regionIDs ?? [];
    map['companyIDs'] = companyIDs ?? [];
    map['childIDs'] = childsIDs;
    map['visitsDate'] = visitsDate;
    map['status'] = status;

    return map;
  }
}
