import 'package:equatable/equatable.dart';

class HUser extends Equatable {
  final String email;
  final String id;
  final DateTime createdAt;
  final String? profilePicUrl;

  const HUser({
    required this.id,
    required this.email,
    required this.createdAt,
    this.profilePicUrl,
  });

  factory HUser.newUser({
    required String email,
  }) {
    return HUser(
      id: "",
      email: email,
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        createdAt,
        profilePicUrl,
      ];

  copyWith({String? profilePicUrl}) {
    return HUser(
      id: id,
      email: email,
      createdAt: createdAt,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }
}
