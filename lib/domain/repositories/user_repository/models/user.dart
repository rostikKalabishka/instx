import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String uid;

  final String email;
  final String username;
  final String imageUrl;
  final String createAt;
  final String status;
  final List<String> followers;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.imageUrl,
    required this.createAt,
    required this.status,
    required this.followers,
  });
  @override
  List<Object?> get props =>
      [uid, email, username, imageUrl, createAt, followers];
  static const UserModel userEmpty = UserModel(
      uid: '',
      email: '',
      username: '',
      createAt: '',
      imageUrl: '',
      status: '',
      followers: []);
  UserModel copyWith(
      {String? uid,
      String? password,
      String? email,
      String? username,
      String? imageUrl,
      String? status,
      List<String>? followers,
      String? createAt}) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        username: username ?? this.username,
        imageUrl: imageUrl ?? this.imageUrl,
        createAt: createAt ?? this.createAt,
        status: status ?? this.status,
        followers: followers ?? this.followers);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

class UserModelField {
  static const String uid = 'uid';
  static const String password = 'password';
  static const String email = 'email';
  static const String username = 'username';
  static const String imageUrl = 'imageUrl';
  static const String createAt = 'createAt';
}
