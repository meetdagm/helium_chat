part of 'create_password_bloc.dart';

class CreatePasswordState {
  final bool isBusy;
  final bool isProcessing;
  final bool canMakeRequest;
  final String password;
  CreatePasswordState({
    this.isBusy = false,
    this.isProcessing = false,
    this.canMakeRequest = false,
    this.password = "",
  });
}
