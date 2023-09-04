part of 'create_password_bloc.dart';

@immutable
sealed class CreatePasswordEvent {
  Stream<CreatePasswordState> handle({
    required String email,
  });
}

class OnCreatePasswordPrimaryCTAPressedEvent extends CreatePasswordEvent {
  final String password;
  OnCreatePasswordPrimaryCTAPressedEvent({
    required this.password,
  });

  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Stream<CreatePasswordState> handle({
    required String email,
  }) async* {
    _navigationService.navigateTo(
      ConfirmPasswordScreen(
        passwordToConfirm: password,
        email: email,
      ),
    );
  }
}

class ValidateCreatePasswordEvent extends CreatePasswordEvent {
  final String password;
  final PasswordValidator _validator = PasswordValidator();

  ValidateCreatePasswordEvent(this.password);
  @override
  Stream<CreatePasswordState> handle({
    required String email,
  }) async* {
    yield CreatePasswordState(
      canMakeRequest: _validator.isValueValid(password),
      password: password,
    );
  }
}
