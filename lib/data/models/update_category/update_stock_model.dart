import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdateStockModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  bool? delete;
  num? count;
  int? visitID;
  String? lat;
  String? lng;

  UpdateStockModel({
    this.id,
    this.userId,
    this.delete,
    this.count,
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
    map['count'] = count;
    map['lat'] = lat;
    map['lng'] = lng;
    map['visitID'] = visitID;

    return map;
  }
}
