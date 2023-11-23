class VisitExpiryModel {
  int? id;
  num? exVal;
  num? excount;
  String? barCode;
  String? barcodeName;
  String? barecodeImage;
  String? categoryname;
  String? pExpireDate;

  VisitExpiryModel({
    this.id,
    this.exVal,
    this.excount,
    this.categoryname,
    this.barecodeImage,
    this.barCode,
    this.barcodeName,
    this.pExpireDate,
  });
  VisitExpiryModel.fromJson(dynamic json) {
    id = json["id"];
    exVal = json["exVal"];
    categoryname = json["categoryname"];
    barecodeImage = json["barecodeImage"];
    excount = json["excount"];
    barCode = json["barCode"];
    barcodeName = json["barcodeName"];
    pExpireDate = json["pExpireDate"];
  }
}
