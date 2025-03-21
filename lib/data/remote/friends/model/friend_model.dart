import 'package:flutter_chat_example/data/remote/users/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel {
  final String? friendId;
  final String? userId;
  final String? friendName;
  final UserModel? friend;
  FriendModel({
    this.friendId,
    this.userId,
    this.friendName,
    this.friend,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}

@JsonSerializable()
class FriendsModel {
  final List<FriendModel> friends;
  FriendsModel({
    required this.friends,
  });

  factory FriendsModel.fromJson(Map<String, dynamic> json) => _$FriendsModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendsModelToJson(this);
}