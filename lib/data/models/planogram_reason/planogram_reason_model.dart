import 'package:networking/client/networking_models/index.dart';

class PlanoGramReasonModel
    implements
        BaseNetworkSerializable,
        BaseNetworkDeserializable<PlanoGramReasonModel> {
  PlanoGramReasonModel({
    this.id,
    this.typeName,
  });

  int? id;
  String? typeName;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['typeName'] = typeName;

    return map;
  }

  @override
  PlanoGramReasonModel fromJson(Map<String, dynamic> json) =>
      PlanoGramReasonModel(
        id: json['id'],
        typeName: json['typeName'],
      );
}
