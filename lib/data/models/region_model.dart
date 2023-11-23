class RegionModel {
  int? id;
  String? value;

  RegionModel({
    this.id,
    this.value,
  });

  RegionModel.fromJson(dynamic json) {
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
