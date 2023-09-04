part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final bool isBusy;
  final bool isProcessing;
  final bool canMakeRequest;
  final String email;

  const LoginState({
    this.isBusy = false,
    this.isProcessing = false,
    this.canMakeRequest = false,
    this.email = "",
  });

  LoginState copyWith({
    bool? isBusy,
    bool? isProcessing,
    bool? canMakeRequest,
    String? email,
  }) {
    return LoginState(
      isBusy: isBusy ?? this.isBusy,
      isProcessing: isProcessing ?? this.isProcessing,
      canMakeRequest: canMakeRequest ?? this.canMakeRequest,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        isBusy,
        isProcessing,
        canMakeRequest,
        email,
      ];
}
