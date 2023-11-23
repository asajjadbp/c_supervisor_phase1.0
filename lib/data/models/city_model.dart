class CityModel {
  int? id;
  String? value;

  CityModel({
    this.id,
    this.value,
  });

  CityModel.fromJson(dynamic json) {
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
