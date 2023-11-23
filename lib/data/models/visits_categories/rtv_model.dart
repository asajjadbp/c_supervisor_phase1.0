class RTVModel {
  int? id;
  int? rtvCount;
  num? rtvVal;
  String? barCode;
  String? barcodeName;
  String? barecodeImage;
  String? categoryname;
  String? reason;
  String? date;
  //String? rtvType;
  RTVModel({
    this.id,
    this.barCode,
    this.barcodeName,
    this.barecodeImage,
    this.categoryname,
   // this.rtvType,
    this.rtvVal,
    this.rtvCount,
    this.reason,
    this.date,

  });
  RTVModel.fromJson(dynamic json) {
    id = json["id"];
    barCode = json["barCode"];
    barcodeName = json["barcodeName"];
    barecodeImage = json["barecodeImage"];
    categoryname = json["categoryname"];
   // rtvType = json["rtvType"];
    rtvVal = json["rtvVal"];
    rtvCount = json["rtvCount"];
    reason = json["reason"];
    date = json["date"];
  }
}
