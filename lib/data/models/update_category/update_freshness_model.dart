import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdateFreshnessModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  bool? delete;
  num? count;
  String? date;
  int? visitID;
  String? lat;
  String? lng;

  UpdateFreshnessModel({
    this.id,
    this.userId,
    this.delete,
    this.count,
    this.date,
    this.lng,
    this.lat,
    this.visitID,
  });

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;

    ///map['delete'] = delete;
    map['count'] = count;
    map['date'] = date;
    map['lng'] = lng;
    map['lat'] = lat;
    map['visitID'] = visitID;
    return map;
  }
}
