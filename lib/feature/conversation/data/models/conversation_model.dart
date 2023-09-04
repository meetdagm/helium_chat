import 'package:equatable/equatable.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';

import '../../../profile/data/model/huser.dart';

class ConversationModel extends Equatable {
  final String chatID;
  final List<HUser> participants;
  final String? lastSentMessage;
  final DateTime lastSentMessageTimeStamp;

  final AuthService _authService = AuthService();

  ConversationModel({
    required this.chatID,
    required this.participants,
    this.lastSentMessage,
    required this.lastSentMessageTimeStamp,
  });

  factory ConversationModel.createEmptyConversation({
    required String chatID,
    required List<HUser> participants,
    required DateTime otherUserAccountCreationDate,
  }) {
    return ConversationModel(
      chatID: chatID,
      participants: participants,
      lastSentMessage: "Start a conversation today",
      lastSentMessageTimeStamp: otherUserAccountCreationDate,
    );
  }

  getOtherUserEmail() {
    return participants
        .firstWhere((participant) =>
            participant.id != _authService.currentAuthenticatedUserID)
        .email;
  }

  ConversationModel copyWithUpdateLastSentMessage(String message) {
    return ConversationModel(
      chatID: chatID,
      participants: participants,
      lastSentMessageTimeStamp: DateTime.now(),
      lastSentMessage: message,
    );
  }

  @override
  List<Object?> get props => [
        chatID,
        lastSentMessage,
        lastSentMessageTimeStamp,
        participants,
      ];
}
