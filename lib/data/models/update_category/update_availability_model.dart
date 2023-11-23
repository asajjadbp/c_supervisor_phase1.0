import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdateAvailabilityModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  int? visitID;
  String? lat;
  String? lng;
  bool? available;
  UpdateAvailabilityModel({
    this.id,
    this.userId,
    this.visitID,
    this.lat,
    this.lng,
    this.available,
  });

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['visitID'] = visitID;
    map['lat'] = lat;
    map['lng'] = lng;
    map['available'] = available;

    return map;
  }
}
