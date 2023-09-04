part of 'confirm_password_bloc.dart';

@immutable
sealed class ConfirmPasswordEvent {
  Stream<ConfirmPasswordState> handle({
    required String email,
    required String password,
  });
}

class OnConfirmPasswordEvent extends ConfirmPasswordEvent {
  // final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = AuthService();

  OnConfirmPasswordEvent();

  @override
  Stream<ConfirmPasswordState> handle({
    required String email,
    required String password,
  }) async* {
    yield ConfirmPasswordState(
      isBusy: true,
      isProcessing: true,
      canMakeRequest: false,
    );
    try {
      await _authService.createAccountWith(
        email: email,
        password: password,
      );
    } catch (e) {
      yield ConfirmPasswordState(
        isBusy: false,
        isProcessing: false,
        canMakeRequest: true,
      );
    }
  }
}

class OnConfirmationPasswordChangedEvent extends ConfirmPasswordEvent {
  final String confirmationPassword;

  OnConfirmationPasswordChangedEvent({
    required this.confirmationPassword,
  });

  @override
  Stream<ConfirmPasswordState> handle({
    required String email,
    required String password,
  }) async* {
    yield ConfirmPasswordState(
      canMakeRequest: password == confirmationPassword,
    );
  }
}
