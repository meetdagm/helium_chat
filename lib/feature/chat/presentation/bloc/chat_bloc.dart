import 'package:bloc/bloc.dart';
import 'package:helium_chat_application/feature/chat/data/models/chat_model.dart';
import 'package:helium_chat_application/feature/chat/data/services/chat_service.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_model.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService;

  ChatBloc({required ConversationModel conversation})
      : _chatService = ChatService(conversationModel: conversation),
        super(ChatState(isLoading: true)) {
    on<ChatEvent>((event, emit) async {
      await emit.forEach(event.handle(prevState: state, bloc: this),
          onData: (state) => state);
    });

    _chatService.streamChat().listen((chatList) {
      add(
        LoadChatEvent(
          chatList: chatList
            ..sort(
              (a, b) => a.sentAt.compareTo(b.sentAt),
            ),
        ),
      );
    });
  }

  sendChat({required String message}) {
    _chatService.sendChatToUser(message: message);
  }

  @override
  Future<void> close() {
    _chatService.close();
    return super.close();
  }
}
