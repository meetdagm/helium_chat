import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:helium_chat_application/feature/conversation/presentation/screen/dashboard_screen.dart';
import 'package:helium_chat_application/feature/signup/presentation/screen/signup_screen.dart';
import 'package:helium_chat_application/feature/startup/data/startup_auth_manager.dart';
import 'package:helium_chat_application/shared_services/locator.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';

part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final StartupAuthStateManager _authStateManager = StartupAuthStateManager();

  StartupBloc() : super(StartupState(isBusy: true)) {
    log("$runtimeType has been initialized");
    on<StartupEvent>(
      (event, emit) async {
        await emit.forEach(
          event.handle(),
          onData: (state) {
            log("$runtimeType -- new data has been received");
            return state;
          },
        );
      },
    );
    _authStateManager.notifyOnAuthChange().listen(
      (isAuthenticated) {
        log("new event $isAuthenticated");
        add(
          StartupAuthChangedEvent(
            isAuthenticated: isAuthenticated,
          ),
        );
      },
    );
    _authStateManager.loginUser();
  }
}
