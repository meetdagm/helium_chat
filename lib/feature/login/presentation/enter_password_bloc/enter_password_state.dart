part of 'enter_password_bloc.dart';

final class EnterPasswordState extends Equatable {
  final bool isBusy;
  final bool canMakeRequest;
  final bool isProcessing;
  final String password;

  const EnterPasswordState({
    this.isBusy = false,
    this.canMakeRequest = false,
    this.isProcessing = false,
    this.password = "",
  });

  EnterPasswordState copyWith({
    bool? isBusy,
    bool? canMakeRequest,
    bool? isProcessing,
    String? password,
  }) {
    return EnterPasswordState(
      isBusy: isBusy ?? this.isBusy,
      canMakeRequest: canMakeRequest ?? this.canMakeRequest,
      isProcessing: isProcessing ?? this.isProcessing,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
        isBusy,
        canMakeRequest,
        isProcessing,
      ];
}
