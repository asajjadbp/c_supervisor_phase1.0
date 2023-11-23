import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdateSOSModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  bool? delete;
  num? shelfCategorySpace;
  num? shelfTotalSpace;
  String? measureUnit;
  List<Photos>? photos;
  int? visitID;
  String? lat;
  String? lng;
  UpdateSOSModel({
    this.id,
    this.userId,
    this.delete,
    this.measureUnit,
    this.shelfCategorySpace,
    this.shelfTotalSpace,
    this.photos,
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
    map['measureUnit'] = measureUnit;
    map['shelfCategorySpace'] = shelfCategorySpace;
    map['shelfTotalSpace'] = shelfTotalSpace;
    map['lat'] = lat;
    map['lng'] = lng;
    map['visitID'] = visitID;
    map['photos'] = photos?.map((photo) => photo.toJson()).toList();
    return map;
  }
}

class Photos implements BaseNetworkSerializable {
  int? id;
  String? photoPath;
  Photos({this.id, this.photoPath});
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['photoPath'] = photoPath;
    return map;
  }
}
