import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepository.login(event.username, event.password);
      result.fold(
        (errorMessage) {
          emit(AuthFailure(errorMessage));
        },
        (user) {
          emit(AuthSuccess(user));
        },
      );
    });
  }
}
