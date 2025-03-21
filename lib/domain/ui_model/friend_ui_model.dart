import 'package:flutter_chat_example/domain/ui_model/user_ui_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/remote/users/model/user_model.dart';

part 'friend_ui_model.g.dart';

@JsonSerializable()
class FriendUiModel {
  final String friendId;
  final String userId;
  final String friendName;
  final UserUiModel friend;

  FriendUiModel({
    required this.friendId,
    required this.userId,
    required this.friendName,
    required this.friend,
  });

  factory FriendUiModel.fromJson(Map<String, dynamic> json) =>
      _$FriendUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendUiModelToJson(this);
}

@JsonSerializable()
class FriendsUiModel {
  final List<FriendUiModel> friends;

  FriendsUiModel({
    required this.friends,
  });

  factory FriendsUiModel.fromJson(Map<String, dynamic> json) =>
      _$FriendsUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsUiModelToJson(this);
}
