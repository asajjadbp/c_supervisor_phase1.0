/// represents otp timer states: (start,end)
abstract class OtpState {}

class TimerBegins extends OtpState {
  TimerBegins();
}

class TimerEnds extends OtpState {}
