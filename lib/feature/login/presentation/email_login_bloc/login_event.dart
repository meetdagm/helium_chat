part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  Stream<LoginState> handle({
    required LoginState prevState,
    required LoginBloc bloc,
  });
}

class OnEmailAddedEvent extends LoginEvent {
  final String email;
  OnEmailAddedEvent(this.email);

  @override
  Stream<LoginState> handle({
    required LoginState prevState,
    required LoginBloc bloc,
  }) async* {
    yield prevState.copyWith(
      canMakeRequest: bloc.validateEmail(email),
      email: email,
    );
  }
}

class OnConfirmPasswordForEmailEvent extends LoginEvent {
  @override
  Stream<LoginState> handle(
      {required LoginState prevState, required LoginBloc bloc}) async* {
    bloc.promptPasswordForEmail(prevState.email);
  }
}
