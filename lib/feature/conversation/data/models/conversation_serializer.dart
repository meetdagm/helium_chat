import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_model.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/data_serializer.dart';

import '../../../profile/data/model/huser.dart';
import '../../../profile/data/model/huser_serializer.dart';

class ConversationSerializer extends DataSerializer<ConversationModel> {
  @override
  ConversationModel fromJson({required String id, required Map data}) {
    log("PARTICIPANTS: ${(data[kParticipants] ?? [])}");
    return ConversationModel(
      chatID: data[kChatID],
      // participants: [],
      participants: List<HUser>.from(
        (data[kParticipants] ?? []).map(
          (participantData) => HUserSerializer().fromJson(
            id: participantData[kID],
            data: participantData,
          ),
        ),
      ),
      lastSentMessage: data[kLastSentMessage],
      lastSentMessageTimeStamp:
          (data[kLastSentMessageTimeStamp] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toJson({required ConversationModel object}) {
    return {
      kChatID: object.chatID,
      kParticipants: List.from(
        object.participants.map(
          (element) => HUserSerializer().toJson(object: element),
        ),
      ),
      kLastSentMessage: object.lastSentMessage,
      kLastSentMessageTimeStamp: object.lastSentMessageTimeStamp,
    };
  }
}
