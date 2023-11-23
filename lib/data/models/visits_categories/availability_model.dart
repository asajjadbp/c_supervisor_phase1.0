class AvailabilityModel {
  AvailabilityModel({
    this.barCode,
    this.pieceCount,
    this.barcodeName,
    this.barecodeImage,
    this.productName,
    this.stokeliststatus,
    this.accessPointId,
    this.available,
    this.id,
  });

  AvailabilityModel.fromJson(dynamic json) {
    barCode = json['barCode'];
    pieceCount = json['pieceCount'];
    barcodeName = json['barcodeName'];
    barecodeImage = json['barecodeImage'];
    productName = json['productName'];
    stokeliststatus = json['stokeliststatus'];
    accessPointId = json['accessPointId'];
    available = json['available'];
    id = json['id'];
  }

  String? barCode;
  int? pieceCount;
  String? barcodeName;
  String? barecodeImage;
  String? productName;
  String? stokeliststatus;
  int? accessPointId;
  String? available;
  int? id;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['barCode'] = barCode;
    map['pieceCount'] = pieceCount;
    map['barcodeName'] = barcodeName;
    map['barecodeImage'] = barecodeImage;
    map['productName'] = productName;
    map['stokeliststatus'] = stokeliststatus;
    map['accessPointId'] = accessPointId;
    map['available'] = available;
    return map;
  }
}
