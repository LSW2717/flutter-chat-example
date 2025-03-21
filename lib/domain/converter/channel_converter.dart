import 'package:flutter_chat_example/data/remote/topics/model/topic_model.dart';
import 'package:flutter_chat_example/domain/converter/topic_converter.dart';
import 'package:flutter_chat_example/domain/ui_model/channel_ui_model.dart';
import '../../data/remote/channels/model/channel_model.dart';

class ChannelConverter {
  static ChannelUiModel toUiModel(ChannelModel channel) {
    return ChannelUiModel(
      channelId: channel.channelId ?? "",
      channelOwner: channel.channelOwner ?? "",
      inviteUsers: channel.inviteUsers ?? [],
      channelName: channel.channelName ?? "",
      joinUsers: channel.joinUsers ?? [],
      lastTopic: TopicConverter.toUiModel(channel.lastTopic ?? TopicModel()),
    );
  }
}
