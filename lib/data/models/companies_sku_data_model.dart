class CompaniesSkuDataModel {
  String? barCode;
  String? barcodeName;
  String? barecodeImage;
  CompaniesSkuDataModel.fromJson(dynamic json) {
    barCode = json['barCode'];
    barcodeName = json['barcodeName'];
    barecodeImage = json['barecodeImage'];
  }
}