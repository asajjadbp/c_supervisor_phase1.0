import 'package:c_supervisor/ui/index.dart';
import 'package:networking/client/networking_models/index.dart';

class EmptyModel implements BaseNetworkDeserializable<EmptyModel> {
  @override
  EmptyModel fromJson(Map<String, dynamic> json) {
    return EmptyModel();
  }
}

class SuccessResponseModel
    implements BaseNetworkDeserializable<SuccessResponseModel> {
  @override
  SuccessResponseModel fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSuccess = json['isSuccess'];
    return SuccessResponseModel(message: message, isSuccess: isSuccess);
  }

  String? message;
  bool? isSuccess;
  SuccessResponseModel({
    this.message,
    this.isSuccess,
  });
}

class ConfirmSuccessResponseModel
    implements BaseNetworkDeserializable<ConfirmSuccessResponseModel> {
  @override
  ConfirmSuccessResponseModel fromJson(Map<String, dynamic> json) {
    message = json['message'];

    return ConfirmSuccessResponseModel(message: message);
  }

  String? message;

  ConfirmSuccessResponseModel({this.message});
}
