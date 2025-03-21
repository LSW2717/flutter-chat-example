import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? userId;
  final String? userName;
  UserModel({
    this.userId,
    this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UsersModel {
  final List<UserModel> users;
  UsersModel({
    required this.users,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => _$UsersModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}