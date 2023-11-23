class CompaniesDataModel {
  int? id;
  String? companyName;
  String? companylogo;
  List<LanguageNameList>? languageNameList;
  int? categoryCount;
  int? brandCount;
  int? productCount;
  int? productBarCodesCount;
  String? companyMode;
  List<SlaDto>? slaDto;
  List<Categories>? categories;
  List<Brands>? brands;
  List<Products>? products;
  CompaniesDataModel.fromJson(dynamic json) {
    id = json["id"];
    companyName = json["companyName"];
    companylogo = json["companylogo"];
    languageNameList = List<LanguageNameList>.from(
        json["languageNameList"].map((x) => LanguageNameList.fromJson(x)));
    categoryCount = json["categoryCount"];
    brandCount = json["brandCount"];
    productCount = json["productCount"];
    productBarCodesCount = json["productBarCodesCount"];
    companyMode = json["companyMode"];
    slaDto = List<SlaDto>.from(json["slaDto"].map((x) => SlaDto.fromJson(x)));

  }
}

class LanguageNameList {
  int? langID;
  String? name;
  LanguageNameList.fromJson(dynamic json) {
    langID = json['langID'];
    name = json['name'];
  }
}

class SlaDto {
  int? componentID;
  String? componentName;
  String? componentImage;
  SlaDto.fromJson(dynamic json) {
    componentID = json['componentID'];
    componentName = json['componentName'];
    componentImage = json['componentImage'];
  }
}

class Categories {
  String? categoryName;
  String? categoryImage;
  Categories.fromJson(dynamic json) {
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
  }
}

class Brands {
  String? brandName;
  String? brandImage;
  Brands.fromJson(dynamic json) {
    brandName = json['brandName'];
    brandImage = json['brandImage'];
  }
}

class Products {
  String? barCode;
  String? barcodeName;
  String? barecodeImage;
  Products.fromJson(dynamic json) {
    barCode = json['barCode'];
    barcodeName = json['barcodeName'];
    barecodeImage = json['barecodeImage'];
  }
}
