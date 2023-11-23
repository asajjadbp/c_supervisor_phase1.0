import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class ResetPasswordUC {
  final ResetPasswordRepo resetPasswordRepo;

  ResetPasswordUC(this.resetPasswordRepo);

  Future<BaseResponse<EmptyModel?>> changePassword(OtpModel otpModel) async {
    return resetPasswordRepo.changePassword(otpModel);
  }

  Future<BaseResponse<EmptyModel?>> forgetPassword(String userName) async {
    return resetPasswordRepo.forgetPassword(userName);
  }

  Future<BaseResponse<EmptyModel?>> verifyCode(OtpModel otpModel) async {
    return resetPasswordRepo.verifyCode(otpModel);
  }
}
