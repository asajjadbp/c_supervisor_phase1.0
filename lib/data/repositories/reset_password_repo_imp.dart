import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/otp_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class ResetPasswordRepoImp implements ResetPasswordRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  ResetPasswordRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<EmptyModel?>> changePassword(OtpModel otpModel) async {
    return applicationRemoteDS.changePassword(otpModel);
  }

  @override
  Future<BaseResponse<EmptyModel?>> forgetPassword(String userName) async {
    return applicationRemoteDS.forgetPassword(userName);
  }

  @override
  Future<BaseResponse<EmptyModel?>> verifyCode(OtpModel otpModel) async {
    return applicationRemoteDS.verifyCode(otpModel);
  }
}
