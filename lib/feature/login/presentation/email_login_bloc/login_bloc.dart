import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helium_chat_application/feature/login/presentation/screen/password_screen.dart';
import 'package:helium_chat_application/shared_services/email_validator.dart';
import 'package:helium_chat_application/shared_services/locator.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final NavigationService _navigationService = locator<NavigationService>();
  LoginBloc() : super(const LoginState(isBusy: false)) {
    on<LoginEvent>((event, emit) async {
      await emit.forEach(
        event.handle(prevState: state, bloc: this),
        onData: (state) => state,
      );
    });
  }

  void promptPasswordForEmail(String email) {
    _navigationService.navigateTo(PasswordScreen(email: email));
  }

  bool validateEmail(String email) {
    return EmailValidator().isValid(email: email);
  }
}
