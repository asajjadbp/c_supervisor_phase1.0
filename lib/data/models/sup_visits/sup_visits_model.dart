class SupVisitsModel {
  SupVisitsModel({
    this.userID,
    this.companylogo,
    this.companyName,
    this.storeName,
    this.cityName,
    this.fullName,
    this.photoPath,
    this.totalNumber,
    this.visitDate,
    this.visitID,
    this.visitStatus,
    this.tmrFullName,
    this.tmrTelephone,
    this.storeLatitude,
    this.storeLongitude,
  });

  SupVisitsModel.fromJson(dynamic json) {
    userID = json['userID'];
    fullName = json['fullName'];
    visitID = json['visitID'];
    visitDate = json['visitDate'];
    tmrFullName = json['tmrFullName'];
    tmrTelephone = json['tmrTelephone'];
    storeName = json['storeName'];
    photoPath = json['photoPath'];
    companyName = json['companyName'];
    companylogo = json['companylogo'];
    cityName = json['cityName'];
    visitStatus = json['visitStatus'];
    totalNumber = json['totalNumber'];
    storeLatitude = json['storeLatitude'];
    storeLongitude = json['storeLongitude'];
  }

  int? userID;
  String? fullName;
  int? visitID;
  String? visitDate;
  String? tmrFullName;
  String? tmrTelephone;
  String? storeName;
  String? photoPath;
  String? companyName;
  String? companylogo;
  String? cityName;
  String? visitStatus;
  int? totalNumber;
  num? storeLatitude;
  num? storeLongitude;

}
