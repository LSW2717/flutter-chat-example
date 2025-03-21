// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendModel _$FriendModelFromJson(Map<String, dynamic> json) => FriendModel(
      friendId: json['friendId'] as String?,
      userId: json['userId'] as String?,
      friendName: json['friendName'] as String?,
      friend: json['friend'] == null
          ? null
          : UserModel.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendModelToJson(FriendModel instance) =>
    <String, dynamic>{
      'friendId': instance.friendId,
      'userId': instance.userId,
      'friendName': instance.friendName,
      'friend': instance.friend,
    };

FriendsModel _$FriendsModelFromJson(Map<String, dynamic> json) => FriendsModel(
      friends: (json['friends'] as List<dynamic>)
          .map((e) => FriendModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendsModelToJson(FriendsModel instance) =>
    <String, dynamic>{
      'friends': instance.friends,
    };
