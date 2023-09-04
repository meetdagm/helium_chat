part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {
  Stream<DashboardState> handle();
}

class OnSettingsPressedEvent extends DashboardEvent {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Stream<DashboardState> handle() async* {
    _navigationService.navigateTo(const ProfileScreen());
  }
}

class OnUsersLoadedEvent extends DashboardEvent {
  final List<ConversationModel> conversations;
  OnUsersLoadedEvent({
    required this.conversations,
  });
  @override
  Stream<DashboardState> handle() async* {
    yield DashboardState(conversationList: conversations);
  }
}

class OnStartChatWithUserIDEvent extends DashboardEvent {
  final ConversationModel conversationModel;
  final NavigationService _navigationService = locator<NavigationService>();
  OnStartChatWithUserIDEvent(this.conversationModel);
  @override
  Stream<DashboardState> handle() async* {
    _navigationService.navigateTo(
      ChatScreen(
        conversationModel: conversationModel,
      ),
    );
  }
}
