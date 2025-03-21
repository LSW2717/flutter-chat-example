// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelUiModel _$ChannelUiModelFromJson(Map<String, dynamic> json) =>
    ChannelUiModel(
      channelId: json['channelId'] as String,
      channelOwner: json['channelOwner'] as String,
      inviteUsers: (json['inviteUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      channelName: json['channelName'] as String,
      joinUsers:
          (json['joinUsers'] as List<dynamic>).map((e) => e as String).toList(),
      lastTopic:
          TopicUiModel.fromJson(json['lastTopic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelUiModelToJson(ChannelUiModel instance) =>
    <String, dynamic>{
      'channelId': instance.channelId,
      'channelOwner': instance.channelOwner,
      'inviteUsers': instance.inviteUsers,
      'channelName': instance.channelName,
      'joinUsers': instance.joinUsers,
      'lastTopic': instance.lastTopic,
    };
