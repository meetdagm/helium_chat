part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {
  Stream<SignupState> handle();
}

class OnNavigateToLoginEvent extends SignupEvent {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Stream<SignupState> handle() async* {
    _navigationService.navigateTo(LoginScreen());
  }
}

class ValidateInputEvent extends SignupEvent {
  final String? email;
  final EmailValidator _validator = EmailValidator();

  ValidateInputEvent({required this.email});

  @override
  Stream<SignupState> handle() async* {
    yield SignupState(
      canMakeRequest: _validator.isValid(
        email: email,
      ),
    );
  }
}

class OnCreatePasswordEvent extends SignupEvent {
  final NavigationService _navigationService = locator<NavigationService>();
  final String email;

  OnCreatePasswordEvent({required this.email});
  @override
  Stream<SignupState> handle() async* {
    _navigationService.navigateTo(
      CreatePasswordScreen(
        email: email,
      ),
    );
  }
}
