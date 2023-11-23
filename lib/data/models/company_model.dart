class CompanyModel {
  int? id;
  String? value;

  CompanyModel({
    this.id,
    this.value,
  });

  CompanyModel.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;

    return map;
  }
}
