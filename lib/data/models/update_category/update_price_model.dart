import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class UpdatePriceModel implements BaseNetworkSerializable {
  int? id;
  int? userId;
  bool? delete;
  num? price;
  num? promotionPrice;
  int? visitID;
  String? lat;
  String? lng;

  UpdatePriceModel({
    this.id,
    this.userId,
    this.delete,
    this.price,
    this.promotionPrice,
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
    map['price'] = price;
    map['promotionPrice'] = promotionPrice;
    map['lat'] = lat;
    map['lng'] = lng;
    map['visitID'] = visitID;
    return map;
  }
}
