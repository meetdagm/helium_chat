part of 'startup_bloc.dart';

class StartupState {
  final bool isBusy;
  final bool? _isAuthenticated;
  StartupState({
    this.isBusy = false,
    bool? isAuthenticated,
  }) : _isAuthenticated = isAuthenticated;

  Widget get route => isBusy
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : _isAuthenticated ?? false
          ? const DashboardScreen()
          : SignupScreen();
}
