import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileStorageService {
  Future<String?> storeFileAtPath({
    required String storagePath,
    required String localFilePath,
  }) async {
    try {
      var storageBucket = FirebaseStorage.instance.ref().child(storagePath);
      return await (await storageBucket.putFile(File(localFilePath)))
          .ref
          .getDownloadURL();
    } catch (e) {
      log("Error occured in $runtimeType -- with message: $e");
      rethrow;
    }
  }
}
