import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdatePlanoGramModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  bool? delete;
  int? planogramReason;
  bool? identical;
  String?imagePath;
  int? visitID;
  String? lat;
  String? lng;

  UpdatePlanoGramModel({
    this.id,
    this.userId,
    this.delete,
    this.planogramReason,
    this.identical,
    this.imagePath,
    this.lat,
    this.lng,
    this.visitID,
  });

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['delete'] = delete;
    map['planogramReason'] = planogramReason;
    map['identical'] = identical;
    map['imagePath'] = imagePath;
    map['lat'] = lat;
    map['lng'] = lng;
    map['visitID'] = visitID;
    return map;
  }
}
