part of 'enter_password_bloc.dart';

sealed class EnterPasswordEvent extends Equatable {
  const EnterPasswordEvent();
  Stream<EnterPasswordState> handle({
    required EnterPasswordState previousState,
    required EnterPasswordBloc bloc,
  });
  @override
  List<Object> get props => [];
}

class OnEnterPasswordEvent extends EnterPasswordEvent {
  final String password;

  const OnEnterPasswordEvent(this.password);
  @override
  Stream<EnterPasswordState> handle({
    required EnterPasswordState previousState,
    required EnterPasswordBloc bloc,
  }) async* {
    yield EnterPasswordState(
      canMakeRequest: bloc.isPasswordValid(password),
      password: password,
    );
  }
}

class OnAuthenticateUserEvent extends EnterPasswordEvent {
  @override
  Stream<EnterPasswordState> handle({
    required EnterPasswordState previousState,
    required EnterPasswordBloc bloc,
  }) async* {
    await bloc.authenticateUser();
  }
}
