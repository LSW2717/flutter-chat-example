import 'package:json_annotation/json_annotation.dart';

import '../../data/remote/topics/model/topic_model.dart';

part 'topic_ui_model.g.dart';

@JsonSerializable()
class TopicUiModel {
  final int topicId;
  final String channelId;
  final String userId;
  final String userName;
  final bool isFirst;
  final TopicCommand command;
  final ContentModel content;
  final List<String> readUsers;

  TopicUiModel({
    required this.topicId,
    required this.channelId,
    required this.userId,
    required this.userName,
    required this.isFirst,
    required this.command,
    required this.content,
    required this.readUsers,
  });

  factory TopicUiModel.fromJson(Map<String, dynamic> json) => _$TopicUiModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicUiModelToJson(this);
}

@JsonSerializable()
class TopicsUiModel {
  final List<TopicUiModel> topics;
  TopicsUiModel({
    required this.topics,
  });

  factory TopicsUiModel.fromJson(Map<String, dynamic> json) => _$TopicsUiModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicsUiModelToJson(this);
}