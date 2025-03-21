import 'package:json_annotation/json_annotation.dart';

import '../../topics/model/topic_model.dart';

part 'channel_model.g.dart';

@JsonSerializable()
class ChannelModel {
  final String? channelId;
  final String? channelOwner;
  final List<String>? inviteUsers;
  final String? channelName;
  final List<String>? joinUsers;
  final TopicModel? lastTopic;

  ChannelModel({
    this.channelId,
    this.channelOwner,
    this.inviteUsers,
    this.channelName,
    this.joinUsers,
    this.lastTopic,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this);
}

@JsonSerializable()
class ChannelsModel {
  final List<ChannelModel> channels;
  ChannelsModel({
    required this.channels,
  });
  factory ChannelsModel.fromJson(Map<String, dynamic> json) => _$ChannelsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelsModelToJson(this);
}