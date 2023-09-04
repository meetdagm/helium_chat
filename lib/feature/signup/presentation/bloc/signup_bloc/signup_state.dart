part of 'signup_bloc.dart';

final class SignupState {
  final bool isBusy;
  final bool isProcessing;
  final bool canMakeRequest;

  SignupState({
    this.isBusy = false,
    this.isProcessing = false,
    this.canMakeRequest = false,
  });
}
