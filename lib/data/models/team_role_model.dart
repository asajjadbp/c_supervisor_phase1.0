import 'package:networking/client/networking_models/index.dart';

class TeamRoleModel implements BaseNetworkDeserializable {
  TeamRoleModel({
    this.id,
    this.value,
  });

  TeamRoleModel.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
  }
  int? id;
  String? value;

  @override
  TeamRoleModel fromJson(Map<String, dynamic> json) =>
      TeamRoleModel(id: json['id'], value: json['value']);
}
