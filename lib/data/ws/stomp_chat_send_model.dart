import 'package:json_annotation/json_annotation.dart';

import '../remote/topics/model/topic_model.dart';

part 'stomp_chat_send_model.g.dart';

abstract class StompChatSendModel {}

@JsonSerializable()
class SendLeaveModel extends StompChatSendModel {
  final TopicCommand command;
  final String channelId;
  final String userId;
  final String userName;

  SendLeaveModel({
    this.command = TopicCommand.LEAVE,
    required this.channelId,
    required this.userId,
    required this.userName,
  });

  factory SendLeaveModel.fromJson(Map<String, dynamic> json) {
    return _$SendLeaveModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SendLeaveModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SendInviteModel extends StompChatSendModel {

  final TopicCommand command;
  final String channelId;
  final String userId;
  @JsonKey(name: 'content')
  final Map<String, dynamic> content;
  final String userName;

  SendInviteModel({
    this.command = TopicCommand.INVITE,
    required this.channelId,
    required this.userId,
    required this.content,
    required this.userName,
  });

  factory SendInviteModel.fromJson(Map<String, dynamic> json) {
    return _$SendInviteModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$SendInviteModelToJson(this);
    return json;
  }
}

@JsonSerializable()
class SendJoinModel extends StompChatSendModel{

  final TopicCommand command;
  final String channelId;
  final String userId;
  final String userName;

  SendJoinModel({
    this.command = TopicCommand.JOIN,
    required this.channelId,
    required this.userId,
    required this.userName,
  });

  factory SendJoinModel.fromJson(Map<String, dynamic> json) => _$SendJoinModelFromJson(json);
  Map<String, dynamic> toJson() => _$SendJoinModelToJson(this);
}

@JsonSerializable()
class SendReceiveModel extends StompChatSendModel {
  final TopicCommand command;
  final String channelId;
  final String userId;
  final int readTopicId;
  final String userName;

  SendReceiveModel({
    this.command = TopicCommand.RECEIVED,
    required this.channelId,
    required this.userId,
    required this.readTopicId,
    required this.userName,
  });

  factory SendReceiveModel.fromJson(Map<String, dynamic> json) {
    return _$SendReceiveModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$SendReceiveModelToJson(this);
    json["content"] = {
      'topicId': json['readTopicId'],
    };
    json.remove('readTopicId');
    return json;
  }
}

@JsonSerializable(explicitToJson: true)
class SendTopicModel extends StompChatSendModel {

  final TopicCommand command;
  final String channelId;
  final String userId;
  final String userName;
  final String? contentType;
  final SendContentModel content;

  SendTopicModel({
    this.command = TopicCommand.SEND,
    required this.channelId,
    required this.userId,
    required this.userName,
    this.contentType,
    required this.content,

  });

  factory SendTopicModel.fromJson(Map<String, dynamic> json) => _$SendTopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$SendTopicModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SendContentModel{
  final String? text;

  SendContentModel({
    this.text,
  });

  factory SendContentModel.fromJson(Map<String, dynamic> json) =>
      _$SendContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendContentModelToJson(this);
}
