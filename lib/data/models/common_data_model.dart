import 'package:networking/client/networking_models/index.dart';

class CommonDataModel
    implements
        BaseNetworkSerializable,
        BaseNetworkDeserializable<CommonDataModel> {
  CommonDataModel({
    this.id,
    this.value,
    this.comment,
  });

  int? id;
  String? value;
  String? comment;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;
    map['comment'] = comment;
    return map;
  }

  @override
  CommonDataModel fromJson(Map<String, dynamic> json) => CommonDataModel(
        id: json['id'],
        value: json['value'],
        comment: json['comment'],
      );
}
