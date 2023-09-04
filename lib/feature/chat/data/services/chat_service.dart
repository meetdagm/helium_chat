import 'dart:async';
import 'dart:developer';

import 'package:helium_chat_application/feature/chat/data/models/chat_model.dart';
import 'package:helium_chat_application/feature/chat/data/models/chat_serializer.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_model.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_serializer.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';
import 'package:helium_chat_application/shared_services/database_service.dart';

class ChatService {
  final DatabaseService<ChatModel> _chatDB;
  final DatabaseService<ConversationModel> _conversationDB;
  final StreamController<List<ChatModel>> _chatController =
      StreamController.broadcast();
  final AuthService _authService = AuthService();
  final ConversationModel _conversationModel;

  ChatService({
    required ConversationModel conversationModel,
  })  : _conversationModel = conversationModel,
        _chatDB = DatabaseService(
          collectionID:
              "$kConversations/${conversationModel.chatID}/$kMessages",
          serializer: ChatSerializer(),
        ),
        _conversationDB = DatabaseService(
          collectionID: kConversations,
          serializer: ConversationSerializer(),
        );

  Stream<List<ChatModel>> streamChat() {
    _chatDB.notifyOnChange().listen(
      (chatList) {
        if (!_chatController.isClosed) {
          _chatController.add(chatList);
        }
      },
    );
    return _chatController.stream;
  }

  Future sendChatToUser({required String message}) async {
    var chat = ChatModel(
      senderID: _authService.currentAuthenticatedUserID,
      sentAt: DateTime.now(),
      content: message,
    );
    try {
      await _chatDB.create(
        object: chat,
      );
      var udpatedObject =
          _conversationModel.copyWithUpdateLastSentMessage(message);
      await _conversationDB.create(
        id: _conversationModel.chatID,
        object: udpatedObject,
      );
    } catch (e) {
      log("error occured in $runtimeType with message - $e");
      rethrow;
    }
  }

  close() async {
    await _chatController.close();
  }
}
