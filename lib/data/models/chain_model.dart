class ChainModel {
  int? id;
  String? value;

  ChainModel({
    this.id,
    this.value,
  });

  ChainModel.fromJson(dynamic json) {
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
