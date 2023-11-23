class CompaniesBrandDataModel {
  String? brandName;
  String? brandImage;
  CompaniesBrandDataModel.fromJson(dynamic json) {
    brandName = json['brandName'];
    brandImage = json['brandImage'];
  }
}
