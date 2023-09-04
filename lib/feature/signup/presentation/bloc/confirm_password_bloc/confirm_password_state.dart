part of 'confirm_password_bloc.dart';

class ConfirmPasswordState {
  final bool isBusy;
  final bool isProcessing;
  final bool canMakeRequest;
  ConfirmPasswordState({
    this.isBusy = false,
    this.isProcessing = false,
    this.canMakeRequest = false,
  });
}
