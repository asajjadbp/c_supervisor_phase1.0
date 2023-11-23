import 'package:networking/client/networking_models/index.dart';

class ActionType implements BaseNetworkDeserializable {
  ActionType({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;
    return map;
  }

  @override
  ActionType fromJson(Map<String, dynamic> json) =>
      ActionType(id: json['id'], value: json['value']);
}
