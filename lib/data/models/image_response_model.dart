import 'package:networking/client/networking_models/index.dart';

class ImageResponseModel
    implements BaseNetworkDeserializable<ImageResponseModel> {
  ImageResponseModel({
    this.imagePathes,
    this.message,
  });

  List<String>? imagePathes;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imagePathes'] = imagePathes;
    map['message'] = message;
    return map;
  }

  @override
  ImageResponseModel fromJson(Map<String, dynamic> json) {
    imagePathes =
        json['imagePathes'] != null ? json['imagePathes'].cast<String>() : [];
    message = json['message'];
    return ImageResponseModel(imagePathes: imagePathes, message: message);
  }
}
