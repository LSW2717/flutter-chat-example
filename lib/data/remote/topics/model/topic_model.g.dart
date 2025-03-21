// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      topicId: (json['topicId'] as num?)?.toInt(),
      channelId: json['channelId'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      isFirst: json['isFirst'] as bool?,
      command: $enumDecodeNullable(_$TopicCommandEnumMap, json['command']),
      content: json['content'] == null
          ? null
          : ContentModel.fromJson(json['content'] as Map<String, dynamic>),
      readUsers: (json['readUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      searchMinTopicId: (json['searchMinTopicId'] as num?)?.toInt(),
      searchMaxTopicId: (json['searchMaxTopicId'] as num?)?.toInt(),
      searchChannelId: json['searchChannelId'] as String?,
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'channelId': instance.channelId,
      'userId': instance.userId,
      'userName': instance.userName,
      'isFirst': instance.isFirst,
      'command': _$TopicCommandEnumMap[instance.command],
      'content': instance.content,
      'readUsers': instance.readUsers,
      'searchMinTopicId': instance.searchMinTopicId,
      'searchMaxTopicId': instance.searchMaxTopicId,
      'searchChannelId': instance.searchChannelId,
    };

const _$TopicCommandEnumMap = {
  TopicCommand.INVITE: 'INVITE',
  TopicCommand.JOIN: 'JOIN',
  TopicCommand.LEAVE: 'LEAVE',
  TopicCommand.RECEIVED: 'RECEIVED',
  TopicCommand.SEND: 'SEND',
};

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) => ContentModel(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

TopicsModel _$TopicsModelFromJson(Map<String, dynamic> json) => TopicsModel(
      topics: (json['topics'] as List<dynamic>)
          .map((e) => TopicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicsModelToJson(TopicsModel instance) =>
    <String, dynamic>{
      'topics': instance.topics,
    };
