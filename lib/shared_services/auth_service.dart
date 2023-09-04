import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/database_service.dart';

import '../feature/profile/data/model/huser.dart';
import '../feature/profile/data/model/huser_serializer.dart';

class AuthService {
  DatabaseService<HUser> userDB = DatabaseService(
    collectionID: kUsers,
    serializer: HUserSerializer(),
  );
  Future createAccountWith({
    required String email,
    required String password,
  }) async {
    try {
      log("This is the email: $email and this is the password: $password");
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var newUser = HUser(
        id: currentAuthenticatedUserID,
        email: email,
        createdAt: DateTime.now(),
      );
      await userDB.create(
        id: currentAuthenticatedUserID,
        object: newUser,
      );
    } catch (e) {
      log("Error when creating user in $runtimeType with error: $e");
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.currentUser!.delete();
      }
      rethrow;
    }
  }

  Future signInUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      log("This is the email: $email and this is the password: $password");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log("Error when signing user in $runtimeType with error: $e");
      rethrow;
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  String get currentAuthenticatedUserID =>
      FirebaseAuth.instance.currentUser?.uid ?? "";
}
