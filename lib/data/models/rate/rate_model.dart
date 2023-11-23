import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_serializable.dart';

class RateModel implements BaseNetworkDeserializable, BaseNetworkSerializable {
  int? userId;
  int? visitId;
  double? rate;
  String? comment;

  /// response
  String? message;
  RateModel({
    this.userId,
    this.visitId,
    this.rate,
    this.comment,
    this.message,
  });
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['visitId'] = visitId;
    map['rate'] = rate;
    map['comment'] = comment;
    return map;
  }

  @override
  RateModel fromJson(Map<String, dynamic> json) {
    return RateModel(
      message: json['message'],
    );
  }
}
