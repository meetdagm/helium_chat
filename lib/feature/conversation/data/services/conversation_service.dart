import 'dart:async';
import 'dart:developer';

import 'package:helium_chat_application/feature/conversation/data/models/conversation_model.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_serializer.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';
import 'package:helium_chat_application/shared_services/database_service.dart';

import '../../../profile/data/model/huser.dart';
import '../../../profile/data/model/huser_serializer.dart';

class ConversationService {
  final DatabaseService<HUser> _userDB = DatabaseService(
    collectionID: kUsers,
    serializer: HUserSerializer(),
  );

  final DatabaseService<ConversationModel> _conversationDB = DatabaseService(
    collectionID: kConversations,
    serializer: ConversationSerializer(),
  );

  final StreamController<List<ConversationModel>> conversationStream =
      StreamController.broadcast();

  final AuthService _authService = AuthService();

  List<ConversationModel> _allConversations = [];

  Stream<List<ConversationModel>> streamAllConversations() {
    _userDB.notifyOnChange().listen(
      (users) async {
        var otherUsers = _removeSelfFromUserList(users);
        var me = _getMyAccount(users);
        _allConversations = await _fetchAllConversationBetween(otherUsers, me);
        conversationStream.add(_allConversations);
      },
    );

    return conversationStream.stream;
  }

  HUser _getMyAccount(List<HUser> users) {
    return users.firstWhere(
        (user) => user.id == _authService.currentAuthenticatedUserID);
  }

  List<HUser> _removeSelfFromUserList(List<HUser> users) {
    log("Users ${_authService.currentAuthenticatedUserID}");
    return users
        .where((user) => user.id != _authService.currentAuthenticatedUserID)
        .toList();
  }

  Future<List<ConversationModel>> _fetchAllConversationBetween(
    List<HUser> users,
    HUser me,
  ) async {
    List<ConversationModel> conversationList = [];
    for (var user in users) {
      var conversationID = _getConversationIDWithUser(user.id);
      var conversationWithUser = await _conversationDB.read(id: conversationID);
      if (conversationWithUser == null) {
        conversationList.add(
          ConversationModel.createEmptyConversation(
            chatID: conversationID,
            participants: [user, me],
            otherUserAccountCreationDate: user.createdAt,
          ),
        );
      } else {
        conversationList.add(conversationWithUser);
      }
    }
    conversationList.sort(
      (a, b) => b.lastSentMessageTimeStamp.compareTo(
        a.lastSentMessageTimeStamp,
      ),
    );
    return conversationList;
  }

  _getConversationIDWithUser(String userID) {
    var isBefore =
        (userID.compareTo(_authService.currentAuthenticatedUserID)) >= 0;
    return isBefore
        ? userID + _authService.currentAuthenticatedUserID
        : _authService.currentAuthenticatedUserID + userID;
  }

  void close() async {
    _userDB.close();
    await conversationStream.close();
  }
}
