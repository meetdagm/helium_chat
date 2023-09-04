import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';

part 'enter_password_event.dart';
part 'enter_password_state.dart';

class EnterPasswordBloc extends Bloc<EnterPasswordEvent, EnterPasswordState> {
  final String email;
  final AuthService _authService = AuthService();

  EnterPasswordBloc(this.email) : super(const EnterPasswordState()) {
    on<EnterPasswordEvent>((event, emit) async {
      await emit.forEach(
        event.handle(previousState: state, bloc: this),
        onData: (state) => state,
      );
    });
  }

  authenticateUser() async {
    if (isPasswordValid(state.password)) {
      await _authService.signInUserWithEmailPassword(
          email: email, password: state.password);
    }
  }

  bool isPasswordValid(String password) {
    return password.length >= 6;
  }
}
