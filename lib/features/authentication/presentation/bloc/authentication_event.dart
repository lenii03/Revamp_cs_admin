abstract class AuthenticationEvent {}

class LoginSubmitted extends AuthenticationEvent {
  final String username;
  final String password;

  LoginSubmitted({required this.username, required this.password});
}

class ForgotPasswordSubmitted extends AuthenticationEvent {
  final String loginId;

  ForgotPasswordSubmitted({required this.loginId});
}
