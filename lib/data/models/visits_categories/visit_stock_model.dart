class VisitStockModel {
  int?id;
  String? categoryname;
  String? barCode;
  String? barcodeName;
  String? barecodeImage;
  num?count;
  num?value;
  VisitStockModel({
    this.id,
    this.categoryname,
    this.barCode,
    this.barcodeName,
    this.barecodeImage,
    this.value,
    this.count,

  });
  VisitStockModel.fromJson(dynamic json) {
    id = json['id'];
    categoryname = json['categoryname'];
    barCode = json['barCode'];
    barcodeName = json['barcodeName'];
    barecodeImage = json['barecodeImage'];
    value = json['value'];
    count = json['count'];
  }
}
