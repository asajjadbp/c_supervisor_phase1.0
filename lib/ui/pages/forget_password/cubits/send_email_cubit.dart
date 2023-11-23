import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

/// [SendEmailCubit] first step to reset password
class SendEmailCubit extends BaseAppCubit<EmptyModel> {
  SendEmailCubit({required this.resetPasswordUC});

  final ResetPasswordUC resetPasswordUC;

  Future<void> forgetPassword({
    required String userName,
    Function()? successCall,
  }) async {
    await networkCall(
      successCall: successCall,
      () => resetPasswordUC.forgetPassword(userName),
    );
  }
}
