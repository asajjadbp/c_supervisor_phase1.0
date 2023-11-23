import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdateRtvModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  bool? delete;
  int? rtvCount;
  int? rtvType;
  String? date;
  int? visitID;
  String? lat;
  String? lng;

  UpdateRtvModel({
    this.id,
    this.userId,
    this.delete,
    this.rtvCount,
    this.rtvType,
    this.date,
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
    map['rtvCount'] = rtvCount;
    map['rtvType'] = rtvType;
    map['date'] = date;
    map['lat'] = lat;
    map['lng'] = lng;
    map['visitID'] = visitID;
    return map;
  }
}
