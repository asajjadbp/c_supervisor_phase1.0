import 'package:networking/client/networking_models/index.dart';
/// pageNumber : 1
/// pageSize : 20
/// childIDs : []
/// roleId : "2022-11-17T12:45:11.921Z"
/// search : "2022-11-17T12:45:11.921Z"
/// userID : 69

class FilterByNameModel implements BaseNetworkSerializable<FilterByNameModel> {
  FilterByNameModel({
    this.pageNumber,
    this.pageSize,
    this.roleId,
    this.search,
    this.userID,
  });

  FilterByNameModel.fromJson(dynamic json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    roleId = json['roleID'];
    search = json['search'];
    userID = json['userID'];
  }
  int? pageNumber;
  int? pageSize;
  String? roleId;
  String? search;
  int? userID;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    map['roleID'] = roleId;
    map['search'] = search;
    map['userID'] = userID;
    return map;
  }
}
