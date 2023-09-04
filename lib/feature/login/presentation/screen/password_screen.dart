import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/login/presentation/enter_password_bloc/enter_password_bloc.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/single_input_field_page.dart';

class PasswordScreen extends StatelessWidget {
  final String email;
  final TextEditingController _editingController = TextEditingController();
  PasswordScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: BlocProvider<EnterPasswordBloc>(
        create: (context) => EnterPasswordBloc(email),
        child: BlocBuilder<EnterPasswordBloc, EnterPasswordState>(
          builder: (context, state) {
            return SingleInputFieldPage(
              editingController: _editingController,
              headline: "Enter your password for $email",
              isTextFieldEnabled: !state.isProcessing,
              textFieldHintText: "Password",
              onTextChange: (value) =>
                  BlocProvider.of<EnterPasswordBloc>(context)
                      .add(OnEnterPasswordEvent(value)),
              isBusy: state.isBusy,
              ctaText: "Continue",
              isCtaEnabled: state.canMakeRequest,
              onCtaPressed: () =>
                  BlocProvider.of<EnterPasswordBloc>(context).add(
                OnAuthenticateUserEvent(),
              ),
            );
          },
        ),
      ),
    );
  }
}
