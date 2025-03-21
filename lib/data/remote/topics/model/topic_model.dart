import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel {
  final int? topicId;
  final String? channelId;
  final String? userId;
  final String? userName;
  final bool? isFirst;
  final TopicCommand? command;
  final ContentModel? content;
  final List<String>? readUsers;

  final int? searchMinTopicId;
  final int? searchMaxTopicId;
  final String? searchChannelId;

  TopicModel({
    this.topicId,
    this.channelId,
    this.userId,
    this.userName,
    this.isFirst,
    this.command,
    this.content,
    this.readUsers,
    this.searchMinTopicId,
    this.searchMaxTopicId,
    this.searchChannelId,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) => _$TopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}

enum TopicCommand{
  INVITE,
  JOIN,
  LEAVE,
  RECEIVED,
  SEND;
}

@JsonSerializable()
class ContentModel {
  final String? text;
  ContentModel({
  this.text,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContentModelToJson(this);
}

@JsonSerializable()
class TopicsModel {
  final List<TopicModel> topics;
  TopicsModel({
    required this.topics,
  });

  factory TopicsModel.fromJson(Map<String, dynamic> json) => _$TopicsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicsModelToJson(this);
}