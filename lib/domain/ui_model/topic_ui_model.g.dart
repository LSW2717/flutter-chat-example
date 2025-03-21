// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicUiModel _$TopicUiModelFromJson(Map<String, dynamic> json) => TopicUiModel(
      topicId: (json['topicId'] as num).toInt(),
      channelId: json['channelId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      isFirst: json['isFirst'] as bool,
      command: $enumDecode(_$TopicCommandEnumMap, json['command']),
      content: ContentModel.fromJson(json['content'] as Map<String, dynamic>),
      readUsers:
          (json['readUsers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TopicUiModelToJson(TopicUiModel instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'userName': instance.userName,
      'isFirst': instance.isFirst,
      'command': _$TopicCommandEnumMap[instance.command]!,
      'content': instance.content,
      'readUsers': instance.readUsers,
    };

const _$TopicCommandEnumMap = {
  TopicCommand.INVITE: 'INVITE',
  TopicCommand.JOIN: 'JOIN',
  TopicCommand.LEAVE: 'LEAVE',
  TopicCommand.RECEIVED: 'RECEIVED',
  TopicCommand.SEND: 'SEND',
};

TopicsUiModel _$TopicsUiModelFromJson(Map<String, dynamic> json) =>
    TopicsUiModel(
      topics: (json['topics'] as List<dynamic>)
          .map((e) => TopicUiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicsUiModelToJson(TopicsUiModel instance) =>
    <String, dynamic>{
      'topics': instance.topics,
    };
