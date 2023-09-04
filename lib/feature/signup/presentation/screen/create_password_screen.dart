import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/signup/presentation/bloc/create_password_bloc/create_password_bloc.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/single_input_field_page.dart';

class CreatePasswordScreen extends StatelessWidget {
  final String email;
  CreatePasswordScreen({
    super.key,
    required this.email,
  });
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: "Create password",
      child: BlocProvider<CreatePasswordBloc>(
        create: (context) => CreatePasswordBloc(
          email: email,
        ),
        child: BlocBuilder<CreatePasswordBloc, CreatePasswordState>(
          builder: (context, state) {
            return SingleInputFieldPage(
              editingController: _editingController,
              ctaText: 'Confirm password',
              headline:
                  "Add a password to your account to make sure it's secure",
              isTextHidden: true,
              isBusy: state.isBusy,
              isCtaEnabled: state.canMakeRequest,
              isTextFieldEnabled: !state.isProcessing,
              onCtaPressed: () =>
                  BlocProvider.of<CreatePasswordBloc>(context).add(
                OnCreatePasswordPrimaryCTAPressedEvent(
                  password: state.password,
                ),
              ),
              onTextChange: (value) =>
                  BlocProvider.of<CreatePasswordBloc>(context).add(
                ValidateCreatePasswordEvent(value),
              ),
              textFieldHintText: 'Password',
            );
          },
        ),
      ),
    );
  }
}
