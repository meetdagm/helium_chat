import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/single_input_field_page.dart';

import '../bloc/confirm_password_bloc/confirm_password_bloc.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  final TextEditingController _editingController = TextEditingController();
  final String passwordToConfirm;
  final String email;
  ConfirmPasswordScreen({
    super.key,
    required this.email,
    required this.passwordToConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: BlocProvider<ConfirmPasswordBloc>(
        create: (context) => ConfirmPasswordBloc(
          password: passwordToConfirm,
          email: email,
        ),
        child: BlocBuilder<ConfirmPasswordBloc, ConfirmPasswordState>(
            builder: (context, state) {
          return SingleInputFieldPage(
            ctaText: "confirm",
            editingController: _editingController,
            headline: 'Confirm your password',
            isBusy: state.isBusy,
            isCtaEnabled: state.canMakeRequest,
            isTextFieldEnabled: !state.isProcessing,
            onCtaPressed: () => BlocProvider.of<ConfirmPasswordBloc>(context)
                .add(OnConfirmPasswordEvent()),
            onTextChange: (value) {
              _editingController.value = TextEditingValue(
                text: value,
                selection: TextSelection.fromPosition(
                  TextPosition(
                    offset: value.length,
                  ),
                ),
              );
              BlocProvider.of<ConfirmPasswordBloc>(context).add(
                OnConfirmationPasswordChangedEvent(
                  confirmationPassword: value,
                ),
              );
            },
            textFieldHintText: '',
          );
        }),
      ),
    );
  }
}
