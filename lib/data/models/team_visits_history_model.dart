class TeamVisitsHistoryModel {
  Details? details;
  List<VisitCompanySLA>? visitCompanySLA;

  TeamVisitsHistoryModel({
    this.details,
    this.visitCompanySLA,
  });
  TeamVisitsHistoryModel.fromJson(dynamic json) {
    details = Details.fromJson(json['details']);
    visitCompanySLA = List<VisitCompanySLA>.from(
        json["visitCompanySLA"].map((x) => VisitCompanySLA.fromJson(x)));
  }
}

class Details {
  int? workerID;
  int? visitID;
  String? visitDate;
  String? storeName;
  String? photoPath;
  String? companyName;
  String? companylogo;
  String? cityName;
  String? visitStatus;
  String? workingHrs;
  String? checkIn;
  String? checkOut;
  double? rate;
  String? rateComment;
  String? workerName;
  num? storeLatitude;
  num? storeLongitude;
  Details({
    this.workerID,
    this.visitID,
    this.visitDate,
    this.storeName,
    this.photoPath,
    this.companyName,
    this.companylogo,
    this.cityName,
    this.visitStatus,
    this.workingHrs,
    this.checkIn,
    this.checkOut,
    this.rate,
    this.rateComment,
    this.workerName,
    this.storeLatitude,
    this.storeLongitude,
  });
  Details.fromJson(dynamic json) {
    workerID = json['workerID'];
    visitID = json['visitID'];
    visitDate = json['visitDate'];
    storeName = json['storeName'];
    photoPath = json['photoPath'];
    companyName = json['companyName'];
    companylogo = json['companylogo'];
    cityName = json['cityName'];
    visitStatus = json['visitStatus'];
    workingHrs = json['workingHrs'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    rate = json['rate'];
    rateComment = json['rateComment'];
    workerName = json['workerName'];
    storeLatitude = json['storeLatitude'];
    storeLongitude = json['storeLongitude'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workerID'] = workerID;
    map['visitID'] = visitID;
    map['visitDate'] = visitDate;
    map['storeName'] = storeName;
    map['photoPath'] = photoPath;
    map['companyName'] = companyName;
    map['companylogo'] = companylogo;
    map['cityName'] = cityName;
    map['visitStatus'] = visitStatus;
    map['workingHrs'] = workingHrs;
    map['checkIn'] = checkIn;
    map['checkOut'] = checkOut;
    map['checkOut'] = checkOut;

    return map;
  }
}

class VisitCompanySLA {
  int? id;
  String? componentName;
  VisitCompanySLA.fromJson(dynamic json) {
    id = json['id'];
    componentName = json['componentName'];
  }
}
