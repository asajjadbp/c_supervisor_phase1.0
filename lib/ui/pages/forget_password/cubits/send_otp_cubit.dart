import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

class SendOTPCubit extends BaseAppCubit<EmptyModel> {
  SendOTPCubit({required this.resetPasswordUC});

  final ResetPasswordUC resetPasswordUC;

  Future<void> verifyCode({
    required OtpModel otpModel,
    Function()? successCall,
  }) async {
    await networkCall(
      successCall: successCall,
      () => resetPasswordUC.verifyCode(otpModel),
    );
  }
}
