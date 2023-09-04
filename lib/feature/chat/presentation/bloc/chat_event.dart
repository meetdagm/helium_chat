part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {
  Stream<ChatState> handle({
    required ChatState prevState,
    required ChatBloc bloc,
  });
}

class LoadChatEvent extends ChatEvent {
  final List<ChatModel> chatList;

  LoadChatEvent({required this.chatList});

  @override
  Stream<ChatState> handle({
    required ChatState prevState,
    required ChatBloc bloc,
  }) async* {
    yield ChatState(chatList: chatList);
  }
}

class NewTextAddedEvent extends ChatEvent {
  final String enteredText;
  NewTextAddedEvent(this.enteredText);
  @override
  Stream<ChatState> handle({
    required ChatState prevState,
    required ChatBloc bloc,
  }) async* {
    yield prevState.copyWith(
      newTypedMessage: enteredText,
    );
  }
}

class SendMessageEvent extends ChatEvent {
  @override
  Stream<ChatState> handle({
    required ChatState prevState,
    required ChatBloc bloc,
  }) async* {
    yield prevState.copyWith(
      newTypedMessage: "",
      isSendingMessage: true,
    );
    bloc.sendChat(message: prevState.unsentMessage);
  }
}
