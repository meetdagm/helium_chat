import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../shared_services/auth_service.dart';

part 'confirm_password_event.dart';
part 'confirm_password_state.dart';

class ConfirmPasswordBloc
    extends Bloc<ConfirmPasswordEvent, ConfirmPasswordState> {
  final String password;
  final String email;

  ConfirmPasswordBloc({
    required this.email,
    required this.password,
  }) : super(ConfirmPasswordState()) {
    on<ConfirmPasswordEvent>(
      (event, emit) async {
        await emit.forEach(
          event.handle(
            password: password,
            email: email,
          ),
          onData: (state) => state,
        );
      },
    );
  }
}
