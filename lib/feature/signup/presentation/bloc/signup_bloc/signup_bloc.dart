import 'package:bloc/bloc.dart';
import 'package:helium_chat_application/feature/login/presentation/screen/login_screen.dart';
import 'package:helium_chat_application/feature/signup/presentation/screen/create_password_screen.dart';
import 'package:helium_chat_application/shared_services/email_validator.dart';
import 'package:helium_chat_application/shared_services/locator.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignupEvent>(
      (event, emit) async {
        await emit.forEach(
          event.handle(),
          onData: (state) => state,
        );
      },
    );
  }
}
