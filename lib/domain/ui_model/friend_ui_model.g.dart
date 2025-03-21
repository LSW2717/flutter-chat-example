// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendUiModel _$FriendUiModelFromJson(Map<String, dynamic> json) =>
    FriendUiModel(
      friendId: json['friendId'] as String,
      userId: json['userId'] as String,
      friendName: json['friendName'] as String,
      friend: UserUiModel.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendUiModelToJson(FriendUiModel instance) =>
    <String, dynamic>{
      'friendId': instance.friendId,
      'userId': instance.userId,
      'friendName': instance.friendName,
      'friend': instance.friend,
    };

FriendsUiModel _$FriendsUiModelFromJson(Map<String, dynamic> json) =>
    FriendsUiModel(
      friends: (json['friends'] as List<dynamic>)
          .map((e) => FriendUiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendsUiModelToJson(FriendsUiModel instance) =>
    <String, dynamic>{
      'friends': instance.friends,
    };
