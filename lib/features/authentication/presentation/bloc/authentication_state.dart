abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {
  final dynamic user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthenticationState {
  final String message;
  AuthFailure(this.message);
}
