// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) => ChannelModel(
      channelId: json['channelId'] as String?,
      channelOwner: json['channelOwner'] as String?,
      inviteUsers: (json['inviteUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      channelName: json['channelName'] as String?,
      joinUsers: (json['joinUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastTopic: json['lastTopic'] == null
          ? null
          : TopicModel.fromJson(json['lastTopic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelOwner': instance.channelOwner,
      'inviteUsers': instance.inviteUsers,
      'channelName': instance.channelName,
      'joinUsers': instance.joinUsers,
      'lastTopic': instance.lastTopic,
    };

ChannelsModel _$ChannelsModelFromJson(Map<String, dynamic> json) =>
    ChannelsModel(
      channels: (json['channels'] as List<dynamic>)
          .map((e) => ChannelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChannelsModelToJson(ChannelsModel instance) =>
    <String, dynamic>{
      'channels': instance.channels,
    };
