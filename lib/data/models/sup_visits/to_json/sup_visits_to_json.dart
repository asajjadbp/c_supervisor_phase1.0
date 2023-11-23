class SupVisitsToJsonModel {
  final int userID;
  final int pageNumber;
  final int pageSize;
  SupVisitsToJsonModel({
    required this.userID,
    required this.pageNumber,
    required this.pageSize,
  });
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    return map;
  }
}
