import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/single_input_field_page.dart';

import '../email_login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _editingController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: "Log in",
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SingleInputFieldPage(
              editingController: _editingController,
              headline: "Enter your email to login",
              isTextFieldEnabled: !state.isProcessing,
              textFieldHintText: "mail@example.com",
              onTextChange: (value) => BlocProvider.of<LoginBloc>(context).add(
                OnEmailAddedEvent(
                  _editingController.text,
                ),
              ),
              isBusy: state.isBusy,
              ctaText: "Continue",
              isCtaEnabled: state.canMakeRequest,
              onCtaPressed: () => BlocProvider.of<LoginBloc>(context)
                  .add(OnConfirmPasswordForEmailEvent()),
            );
            // return Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Column(
            //     children: [
            //       verticalMediumSpace,
            //       Expanded(
            //         child: ListView(
            //           physics: const ClampingScrollPhysics(),
            //           children: [
            //             verticalMediumSpace,
            //             Text(
            //               'Enter your email to log in to your account',
            //               style: BaseFonts.headline(),
            //               textAlign: TextAlign.center,
            //             ),
            //             verticalLargeSpace,
            //             TextField(
            //               autofocus: true,
            //               enabled: !state.isProcessing,
            //               style: BaseFonts.body(),
            //               maxLines: 5,
            //               cursorColor: BaseColors.primary,
            //               cursorHeight: 24,
            //               textAlign: TextAlign.center,
            //               decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 hintText: "mail@example.com",
            //                 hintStyle: BaseFonts.body(
            //                   color: BaseColors.grey,
            //                 ),
            //                 labelStyle: BaseFonts.body(),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       BusyButton(
            //         title: "Continue",
            //         busy: state.isBusy,
            //         enabled: state.canMakeRequest,
            //         onPressed: () => print("Hi"),
            //       ),
            //       verticalSmallSpace,
            //     ],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
