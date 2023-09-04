import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helium_chat_application/feature/chat/data/models/chat_model.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/data_serializer.dart';

class ChatSerializer extends DataSerializer<ChatModel> {
  @override
  ChatModel fromJson({required String id, required Map data}) {
    return ChatModel(
      senderID: data[kSenderID],
      sentAt: (data[kSentAt] as Timestamp).toDate(),
      content: data[kContent],
    );
  }

  @override
  Map<String, dynamic> toJson({required ChatModel object}) {
    return {
      kSenderID: object.senderID,
      kContent: object.content,
      kSentAt: object.sentAt,
    };
  }
}
