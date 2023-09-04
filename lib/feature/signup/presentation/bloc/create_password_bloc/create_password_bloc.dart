import 'package:bloc/bloc.dart';
import 'package:helium_chat_application/feature/signup/presentation/screen/confirm_password_screen.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';
import 'package:helium_chat_application/shared_services/password_validator.dart';
import 'package:meta/meta.dart';

import '../../../../../shared_services/locator.dart';

part 'create_password_event.dart';
part 'create_password_state.dart';

class CreatePasswordBloc
    extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  final String email;
  CreatePasswordBloc({
    required this.email,
  }) : super(CreatePasswordState()) {
    on<CreatePasswordEvent>(
      (event, emit) async {
        await emit.forEach(
          event.handle(
            email: email,
          ),
          onData: (state) => state,
        );
      },
    );
  }
}
