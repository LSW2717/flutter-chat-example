import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_chat_example/domain/ui_model/topic_ui_model.dart';
import 'package:pretty_json/pretty_json.dart';

import '../../data/remote/rooms/model/room_model.dart';
import '../../data/remote/topics/model/topic_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../ui_model/room_ui_model.dart';

class TopicConverter {
  static TopicUiModel toUiModel(TopicModel topic) {
    return TopicUiModel(
      topicId: topic.topicId ?? 0,
      channelId: topic.channelId ?? "",
      userId: topic.userId ?? "",
      userName: topic.userName ?? "",
      isFirst: topic.isFirst ?? false,
      command: topic.command ?? TopicCommand.SEND,
      content: topic.content ?? ContentModel(text: ""),
      readUsers: topic.readUsers ?? [],
    );
  }

  static CollectionModel<TopicsUiModel> toUiModelList(
    CollectionModel<TopicsModel> topics,
  ) {
    return CollectionModel<TopicsUiModel>(
      embedded: TopicsUiModel(
        topics: topics.embedded.topics.map(toUiModel).toList(),
      ),
      page: topics.page,
    );
  }

  static List<types.Message> toMessageModelList(
    List<TopicUiModel> topics,
    List<RoomMemberUiModel> roomMembers,
  ) {
    List<types.Message> messages = [];

    for (var topic in topics) {
      messages.add(toMessageModel(topic, roomMembers));
    }
    return messages;
  }

  static types.Message toMessageModel(
    TopicUiModel message,
    List<RoomMemberUiModel> roomMembers,
  ) {
    final member = roomMembers
        .where(
          (member) => member.userId == message.userId,
        )
        .toList();

    types.User user = types.User(
      id: message.userId,
      firstName: member.isNotEmpty ? member[0].userName : message.userName,
    );
    final readUsers = message.readUsers;
    switch (message.command) {
      case TopicCommand.SEND:
        return types.CustomMessage(
          author: user,
          id: message.topicId.toString(),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          metadata: {
            'readUsers': readUsers,
            'content': {'text': message.content.text},
          },
        );
      case TopicCommand.JOIN:
        return types.SystemMessage(
          author: user,
          id: message.topicId.toString(),
          text: '${user.firstName ?? message.userName} 님이 채팅에 참여하였습니다',
          metadata: {'readUsers': readUsers},
        );
      case TopicCommand.INVITE:
        return types.SystemMessage(
          author: user,
          id: message.topicId.toString(),
          text: '${message.userName} 님을 채팅에 초대했습니다',
          metadata: {'readUsers': readUsers},
        );
      case TopicCommand.LEAVE:
        return types.SystemMessage(
          author: user,
          id: message.topicId.toString(),
          text: '${user.firstName ?? message.userName} 님이 대화방을 나갔습니다',
          metadata: {'readUsers': readUsers},
        );
      default:
        throw UnimplementedError('Command ${message.command} not supported');
    }
  }
}
