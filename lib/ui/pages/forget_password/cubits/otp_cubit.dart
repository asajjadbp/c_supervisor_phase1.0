import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_state.dart';

/// Handle otp timer states and hold entered pin code to get it whenever entered
class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(TimerBegins());

  String? pinCode;

  /// to check if code can be resent to user again
  bool canResend = true;
  void startTimer() {
    emit(TimerBegins());
  }

  void endTimer() {
    emit(TimerEnds());
  }
}
