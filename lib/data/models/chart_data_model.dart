class ChartDataModel {
  ChartDataModel({
    this.id,
    this.valueInPercentage,
    this.title,
    this.color,
  });

  ChartDataModel.fromJson(dynamic json) {
    id = json['id'];
    valueInPercentage = json['valueInPercentage'];
    title = json['title'];
    color = json['color'];
    count = json['count'];
  }
  int? id;
  int? count;
  num? valueInPercentage;
  String? title;
  String? color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['valueInPercentage'] = valueInPercentage;
    map['title'] = title;
    map['color'] = color;
    map['count'] = count;
    return map;
  }
}
