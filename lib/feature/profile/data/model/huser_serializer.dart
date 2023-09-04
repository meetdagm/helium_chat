import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helium_chat_application/helpers/db_constants.dart';
import 'package:helium_chat_application/shared_services/data_serializer.dart';

import 'huser.dart';

class HUserSerializer extends DataSerializer<HUser> {
  @override
  HUser fromJson({required String id, required Map data}) {
    return HUser(
      id: data[kID],
      email: data[kEmail],
      createdAt: (data[kCreatedAt] as Timestamp).toDate(),
      profilePicUrl: data[kProfilePic],
    );
  }

  @override
  Map<String, dynamic> toJson({required HUser object}) {
    return {
      kID: object.id,
      kEmail: object.email,
      kCreatedAt: object.createdAt,
      kProfilePic: object.profilePicUrl,
    };
  }
}
