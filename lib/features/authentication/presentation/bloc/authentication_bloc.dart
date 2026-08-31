import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  bool _isLoginInProgress = false;

  AuthenticationBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      if (_isLoginInProgress) return;
      _isLoginInProgress = true;
      try {
        emit(AuthLoading());
        final result = await authRepository.login(
          event.username,
          event.password,
        );
        result.fold(
          (errorMessage) {
            emit(AuthFailure(errorMessage));
          },
          (user) {
            emit(AuthSuccess(user));
          },
        );
      } finally {
        _isLoginInProgress = false;
      }
    });

    on<ForgotPasswordSubmitted>((event, emit) async {
      emit(ForgotPasswordLoading());
      final result = await authRepository.resetPassword(event.loginId);
      result.fold(
        (errorMessage) {
          emit(ForgotPasswordFailure(errorMessage));
        },
        (successMessage) {
          emit(ForgotPasswordSuccess(successMessage));
        },
      );
    });
  }
}
