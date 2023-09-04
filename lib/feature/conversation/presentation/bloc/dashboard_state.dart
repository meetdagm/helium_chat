part of 'dashboard_bloc.dart';

final class DashboardState extends Equatable {
  final bool isLoading;
  final List<ConversationModel> _conversationList;
  const DashboardState({
    this.isLoading = false,
    List<ConversationModel> conversationList = const [],
  }) : _conversationList = conversationList;

  int get count => _conversationList.length;

  String getEmailAtIndex(int index) =>
      _conversationList[index].getOtherUserEmail();
  String getDescriptionAtIndex(int index) =>
      _conversationList[index].lastSentMessage.toString();
  String getTimestampAtIndex(int index) =>
      DateFormat.Hm().format(_conversationList[index].lastSentMessageTimeStamp);

  ConversationModel getConversationAtIndex(int index) =>
      _conversationList[index];

  @override
  List<Object?> get props => [
        isLoading,
        _conversationList,
      ];
}
