import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class StartupAuthStateManager {
  final StreamController<bool> _authStreamController =
      StreamController<bool>.broadcast();

  loginUser() async {
    _authStreamController.sink.add(false);
  }

  Stream<bool> notifyOnAuthChange() {
    FirebaseAuth.instance.authStateChanges().listen(
      (event) {
        log("Notify on Auth has changed == ${event != null}");
        _authStreamController.add(event != null);
      },
    );
    return _authStreamController.stream;
  }
}
