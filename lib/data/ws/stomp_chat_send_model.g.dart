// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stomp_chat_send_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendLeaveModel _$SendLeaveModelFromJson(Map<String, dynamic> json) =>
    SendLeaveModel(
      command: $enumDecodeNullable(_$TopicCommandEnumMap, json['command']) ??
          TopicCommand.LEAVE,
      channelId: json['channelId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$SendLeaveModelToJson(SendLeaveModel instance) =>
    <String, dynamic>{
      'command': _$TopicCommandEnumMap[instance.command]!,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'userName': instance.userName,
    };

const _$TopicCommandEnumMap = {
  TopicCommand.INVITE: 'INVITE',
  TopicCommand.JOIN: 'JOIN',
  TopicCommand.LEAVE: 'LEAVE',
  TopicCommand.RECEIVED: 'RECEIVED',
  TopicCommand.SEND: 'SEND',
};

SendInviteModel _$SendInviteModelFromJson(Map<String, dynamic> json) =>
    SendInviteModel(
      command: $enumDecodeNullable(_$TopicCommandEnumMap, json['command']) ??
          TopicCommand.INVITE,
      channelId: json['channelId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as Map<String, dynamic>,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$SendInviteModelToJson(SendInviteModel instance) =>
    <String, dynamic>{
      'command': _$TopicCommandEnumMap[instance.command]!,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'content': instance.content,
      'userName': instance.userName,
    };

SendJoinModel _$SendJoinModelFromJson(Map<String, dynamic> json) =>
    SendJoinModel(
      command: $enumDecodeNullable(_$TopicCommandEnumMap, json['command']) ??
          TopicCommand.JOIN,
      channelId: json['channelId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$SendJoinModelToJson(SendJoinModel instance) =>
    <String, dynamic>{
      'command': _$TopicCommandEnumMap[instance.command]!,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'userName': instance.userName,
    };

SendReceiveModel _$SendReceiveModelFromJson(Map<String, dynamic> json) =>
    SendReceiveModel(
      command: $enumDecodeNullable(_$TopicCommandEnumMap, json['command']) ??
          TopicCommand.RECEIVED,
      channelId: json['channelId'] as String,
      userId: json['userId'] as String,
      readTopicId: (json['readTopicId'] as num).toInt(),
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$SendReceiveModelToJson(SendReceiveModel instance) =>
    <String, dynamic>{
      'command': _$TopicCommandEnumMap[instance.command]!,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'readTopicId': instance.readTopicId,
      'userName': instance.userName,
    };

SendTopicModel _$SendTopicModelFromJson(Map<String, dynamic> json) =>
    SendTopicModel(
      command: $enumDecodeNullable(_$TopicCommandEnumMap, json['command']) ??
          TopicCommand.SEND,
      channelId: json['channelId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      contentType: json['contentType'] as String?,
      content:
          SendContentModel.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendTopicModelToJson(SendTopicModel instance) =>
    <String, dynamic>{
      'command': _$TopicCommandEnumMap[instance.command]!,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'userName': instance.userName,
      'contentType': instance.contentType,
      'content': instance.content.toJson(),
    };

SendContentModel _$SendContentModelFromJson(Map<String, dynamic> json) =>
    SendContentModel(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$SendContentModelToJson(SendContentModel instance) =>
    <String, dynamic>{
      if (instance.text case final value?) 'text': value,
    };
