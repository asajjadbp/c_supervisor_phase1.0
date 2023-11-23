class VisitPriceModel {
  int? id;
  num? priceVariation;
  num? rsp;
  num? price;
  num? promotionPrice;
  String? barCode;
  String? barcodeName;
  String? barecodeImage;
  String? categoryname;

  VisitPriceModel({
    this.id,
    this.priceVariation,
    this.categoryname,
    this.barecodeImage,
    this.rsp,
    this.price,
    this.promotionPrice,
    this.barCode,
    this.barcodeName,
  });
  VisitPriceModel.fromJson(dynamic json) {
    id = json["id"];
    priceVariation = json["priceVariation"];
    categoryname = json["categoryname"];
    barecodeImage = json["barecodeImage"];
    rsp = json["rsp"];
    price = json["price"];
    promotionPrice = json["promotionPrice"];
    barCode = json["barCode"];
    barcodeName = json["barcodeName"];
  }
}
