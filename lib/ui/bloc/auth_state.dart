/// Auth State
abstract class AuthState {
  const AuthState();
}

/// Splash State which performs the splash screen operations
class SplashState extends AuthState {
  SplashState({this.currentIntroPageNumber});
  final int? currentIntroPageNumber;
}

/// Logged-In & Authorized User State. Holds a token.
class AuthorizedState extends AuthState {
  AuthorizedState();
}

/// Unauthorized State
class UnauthorizedState extends AuthState {
  UnauthorizedState([this.stateId]);
  final int? stateId;

  @override
  bool operator ==(Object other) =>
      other is UnauthorizedState && stateId == other.stateId;

  @override
  int get hashCode => hashCode;
}

/// raised in case of network error
class NetworkErrorState extends AuthState {}
