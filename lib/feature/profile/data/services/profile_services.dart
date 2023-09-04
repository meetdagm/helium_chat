import 'dart:async';

import 'package:helium_chat_application/feature/profile/data/model/huser.dart';
import 'package:helium_chat_application/feature/profile/data/model/huser_serializer.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';
import 'package:helium_chat_application/shared_services/database_service.dart';

class ProfileServices {
  final String? userID;
  //If we want to get another users data we just inject it in here.
  ProfileServices({
    this.userID,
  });

  final DatabaseService<HUser> _userDB = DatabaseService(
    collectionID: kUsers,
    serializer: HUserSerializer(),
  );

  final AuthService _authService = AuthService();

  final StreamController<HUser> _userStreamController =
      StreamController.broadcast();

  Stream<HUser> onUserData() {
    _userDB
        .notifyOnDocumentChangeWith(
      id: userID ?? _authService.currentAuthenticatedUserID,
    )
        .listen((userData) {
      if (!_userStreamController.isClosed && userData != null) {
        _userStreamController.add(userData);
      }
    });
    return _userStreamController.stream;
  }

  updateUserDataWith(HUser newUser) async {
    try {
      if (_canUpdateDataForUserWithID(newUser.id)) {
        await _userDB.update(
          id: userID ?? _authService.currentAuthenticatedUserID,
          updatedObject: newUser,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  bool _canUpdateDataForUserWithID(String id) {
    return id == _authService.currentAuthenticatedUserID;
  }

  close() {
    _userStreamController.close();
  }
}
