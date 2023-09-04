part of 'chat_bloc.dart';

class ChatState {
  final bool isLoading;
  late final List<ChatModel> _chatList;
  final String unsentMessage;
  final bool isSendingMessage;

  ChatState({
    this.isLoading = false,
    List<ChatModel> chatList = const [],
    this.unsentMessage = "",
    this.isSendingMessage = false,
  }) : _chatList = chatList;

  int get count => _chatList.length;

  bool get isEmpty => _chatList.isEmpty;

  bool get hasEnteredMessage => unsentMessage.isNotEmpty;

  String getContentAtIndex(int index) {
    return _chatList[index].content;
  }

  ChatState copyWith({
    String? newTypedMessage,
    bool? isLoading,
    List<ChatModel>? chatList,
    bool? isSendingMessage,
    bool? isMessageEmpty,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      chatList: chatList ?? _chatList,
      unsentMessage: newTypedMessage ?? unsentMessage,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
    );
  }

  bool didOtherUserSendMessageAtIndex(int index) {
    final AuthService authService = AuthService();
    return _chatList[index].senderID != authService.currentAuthenticatedUserID;
  }

  String getMessageSentAtTime(int index) {
    return DateFormat.Hm().format(_chatList[index].sentAt);
  }
}
