import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/startup/presentation/bloc/startup_bloc.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartupBloc>(
      create: (context) => StartupBloc(),
      child: BlocBuilder<StartupBloc, StartupState>(
        builder: (context, state) {
          return Scaffold(
            body: state.route,
          );
        },
      ),
    );
  }
}
