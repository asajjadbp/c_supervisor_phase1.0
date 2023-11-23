class TeamJourneyPlanModel {
  int? userID;
  String? fullName;
  int? visitID;
  String? visitDate;
  String? storeName;
  String? photoPath;
  String? companyName;
  String? companylogo;
  String? cityName;
  String? visitStatus;

  TeamJourneyPlanModel({
    this.userID,
    this.fullName,
    this.visitID,
    this.visitDate,
    this.storeName,
    this.photoPath,
    this.companyName,
    this.companylogo,
    this.cityName,
    this.visitStatus,
  });

  TeamJourneyPlanModel.fromJson(dynamic json) {
    userID = json['userID'];
    fullName = json['fullName'];
    visitID = json['visitID'];
    visitDate = json['visitDate'];
    storeName = json['storeName'];
    photoPath = json['photoPath'];
    companyName = json['companyName'];
    companylogo = json['companylogo'];
    cityName = json['cityName'];
    visitStatus = json['visitStatus'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['fullName'] = fullName;
    map['visitID'] = visitID;
    map['visitDate'] = visitDate;
    map['storeName'] = storeName;
    map['photoPath'] = photoPath;
    map['companyName'] = companyName;
    map['companylogo'] = companylogo;
    map['cityName'] = cityName;
    map['visitStatus'] = visitStatus;
    return map;
  }
}
