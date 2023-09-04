part of 'startup_bloc.dart';

@immutable
sealed class StartupEvent {
  Stream<StartupState> handle();
}

class StartupAuthChangedEvent extends StartupEvent {
  final NavigationService _navigationService = locator<NavigationService>();
  final bool isAuthenticated;
  StartupAuthChangedEvent({
    required this.isAuthenticated,
  });
  @override
  Stream<StartupState> handle() async* {
    _navigationService.reset();
    yield StartupState(
      isAuthenticated: isAuthenticated,
    );
  }
}
