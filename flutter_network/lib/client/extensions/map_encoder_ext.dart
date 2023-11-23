import 'dart:convert';


extension MapEncoderExt on Map {
  String toJson() {
    return jsonEncode(this);
  }

}
