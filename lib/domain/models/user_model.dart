import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String uid;
  final String name;
  final String username;
  final DateTime createAt;
  final String? imageUrl;

  const UserModel(
      {required this.uid,
      required this.name,
      required this.username,
      required this.createAt,
      required this.imageUrl});

  @override
  List<Object?> get props => [uid, name, username, createAt, imageUrl];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
