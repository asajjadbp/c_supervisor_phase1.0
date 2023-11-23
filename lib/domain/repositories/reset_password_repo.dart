import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class ResetPasswordRepo {
  Future<BaseResponse<EmptyModel?>> changePassword(OtpModel otpModel);
  Future<BaseResponse<EmptyModel?>> verifyCode(OtpModel otpModel);
  Future<BaseResponse<EmptyModel?>> forgetPassword(String email);
}
