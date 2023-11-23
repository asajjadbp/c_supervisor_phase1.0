import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

class ChangePasswordCubit extends BaseAppCubit<EmptyModel> {
  ChangePasswordCubit({required this.resetPasswordUC});

  final ResetPasswordUC resetPasswordUC;

  Future<void> changePassword({
    required OtpModel otpModel,
    Function()? successCall,
  }) async {
    await networkCall(
      successCall: successCall,
      () => resetPasswordUC.changePassword(otpModel),
    );
  }
}
