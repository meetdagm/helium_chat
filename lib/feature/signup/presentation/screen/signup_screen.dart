import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/signup/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:helium_chat_application/helpers/base_colors.dart';
import 'package:helium_chat_application/helpers/base_fonts.dart';
import 'package:helium_chat_application/widgets/busy_button.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/spacer_widgets.dart';
import 'package:helium_chat_application/widgets/teritiary_button.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _editingController = TextEditingController();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: "Sign up",
      child: BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: BlocBuilder<SignupBloc, SignupState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  verticalMediumSpace,
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        verticalMediumSpace,
                        Text(
                          'Enter your email to create your account',
                          style: BaseFonts.headline(),
                          textAlign: TextAlign.center,
                        ),
                        verticalLargeSpace,
                        TextField(
                          controller: _editingController,
                          autofocus: true,
                          enabled: !state.isProcessing,
                          style: BaseFonts.body(),
                          maxLines: 5,
                          cursorColor: BaseColors.primary,
                          cursorHeight: 24,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "mail@example.com",
                            hintStyle: BaseFonts.body(
                              color: BaseColors.grey,
                            ),
                            labelStyle: BaseFonts.body(),
                          ),
                          onChanged: (value) {
                            _editingController.value = TextEditingValue(
                              text: value,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: value.length),
                              ),
                            );
                            BlocProvider.of<SignupBloc>(context).add(
                              ValidateInputEvent(
                                email: value,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BusyButton(
                    title: "Continue",
                    busy: state.isBusy,
                    enabled: state.canMakeRequest,
                    onPressed: () => BlocProvider.of<SignupBloc>(context).add(
                      OnCreatePasswordEvent(
                        email: _editingController.text,
                      ),
                    ),
                  ),
                  verticalSmallSpace,
                  TeritiaryButton(
                    title: "Already have an account? Log in",
                    onPressed: () => BlocProvider.of<SignupBloc>(context).add(
                      OnNavigateToLoginEvent(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
