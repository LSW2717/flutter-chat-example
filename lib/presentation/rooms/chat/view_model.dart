import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_example/domain/converter/topic_converter.dart';
import 'package:flutter_chat_example/domain/repository/rooms_repository.dart';
import 'package:flutter_chat_example/domain/ui_model/room_ui_model.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../common/auth/auth_state_provider.dart';
import '../../../data/remote/topics/model/topic_model.dart';
import '../../../data/ws/stomp_chat.dart';
import '../../../data/ws/stomp_chat_send_model.dart';
import '../../../domain/ui_model/topic_ui_model.dart';

part 'view_model.g.dart';

@riverpod
class ViewModel extends _$ViewModel {
  @protected
  late RoomsRepository roomsRepository;

  @protected
  late StompChat stompChat;

  @protected
  late AuthState auth;

  String get _userId => auth.userId ?? "";

  bool isFirst = false;

  int minTopicId = 2000000000000;

  int maxTopicId = 0;

  @override
  State build(String roomId) {
    roomsRepository = ref.watch(roomsRepositoryProvider);
    stompChat = ref.watch(stompChatProvider);
    auth = ref.read(authProvider);
    connectWithRoom();
    return InitState();
  }

  Future<void> connectWithRoom() async {
    await roomsRepository.readRoom(roomId).then((room) async {

      final res = await roomsRepository.searchTopics(
        channelId: room.channel.channelId,
        searchMinTopicId: room.channel.lastTopic.topicId == 0
            ? null
            : room.channel.lastTopic.topicId + 1,
      );

      final topics = res.embedded.topics;

      printPrettyJson(room.roomMembers);

      final messages = TopicConverter.toMessageModelList(
        topics,
        room.roomMembers,
      );

      if (topics.isEmpty || topics.last.isFirst) {
        isFirst = true;
      }

      state = LoadedState(
        room: room,
        messages: messages,
      );

      await stompChat.join(
        channelId: room.channel.channelId,
        userId: _userId,
        onReceived: onReceivedMessages,
      );

      if (!room.channel.joinUsers.contains(_userId)) {
        SendJoinModel message = SendJoinModel(
          channelId: room.channel.channelId,
          userId: auth.userId ?? "",
          userName: auth.userName ?? "",
        );

        await stompChat.sendMessage(message);
      }

      await updateChatMessages(topics);
    });
  }

  Future<void> sendMessage({
    required String text,
  }) async {

    final pState = state;

    if (pState is! LoadedState) return;

    final topic = SendTopicModel(
      channelId: pState.room.channel.channelId,
      userId: auth.userId ?? '',
      userName: auth.userName ?? '',
      content: SendContentModel(
        text: text,
      ),
    );

    printPrettyJson(topic);

    await stompChat.sendMessage(topic);
  }

  Future<void> loadMoreMessages() async {
    if (isFirst) {
      return;
    }

    final pState = state;

    if (pState is! LoadedState) return;

    await roomsRepository
        .searchTopics(
      channelId: pState.room.channel.channelId,
      searchMinTopicId: minTopicId,
    )
        .then(
      (res) async {
        await updateChatMessages(res.embedded.topics);

        final topics = res.embedded.topics;

        if (topics.isEmpty || topics.last.isFirst || topics.length < 20) {
          isFirst = true;
        }
        print('✅ fetchRoomChats send end receive msg : $res');

        final newMessages = TopicConverter.toMessageModelList(
          res.embedded.topics,
          pState.room.roomMembers,
        );

        state = LoadedState(
          room: pState.room,
          messages: [...pState.messages, ...newMessages],
        );
      },
      onError: (error) {
        print('❌ fetchRoomChats error : $error');
      },
    );
  }

  Future<void> reconnect() async {
    if (stompChat.isConnected()) {
      await stompChat.disconnect();
    }
    await connectWithRoom();
  }

  Future<void> onReceivedMessages(TopicUiModel message) async {
    final pState = state;

    if (pState is! LoadedState) return;

    await sendReceiveMessage(message);

    if (message.command == TopicCommand.INVITE ||
        message.command == TopicCommand.JOIN) {
      await fetchRoom().then((_) async {
        final uiMessage = TopicConverter.toMessageModel(
          message,
          pState.room.roomMembers,
        );

        await _saveMessage(uiMessage);
      });
    } else {
      final uiMessage = TopicConverter.toMessageModel(
        message,
        pState.room.roomMembers,
      );

      await _saveMessage(uiMessage);
    }
  }

  Future<void> sendReceiveMessage(TopicUiModel message) async {
    final pState = state;

    if (pState is! LoadedState) return;

    final receiveMessage = SendReceiveModel(
      channelId: pState.room.channel.channelId,
      userId: _userId,
      userName: auth.userName ?? "",
      readTopicId: message.topicId,
    );

    await stompChat.sendMessage(receiveMessage);
  }

  Future<void> _saveMessage(types.Message message) async {
    final pState = state;

    if (pState is! LoadedState) return;

    final messages = pState.messages;

    final duplicateIndex = messages.indexWhere(
      (element) => element.id == message.id,
    );

    if (duplicateIndex != -1 && messages[duplicateIndex] != message) {
      messages[duplicateIndex] = message;
      state = LoadedState(room: pState.room, messages: messages);
    } else {
      final latestMessage = messages.firstOrNull;

      // 메시지 ID가 null이 아닌 경우에만 처리
      final latestMessageId = int.tryParse(latestMessage?.id ?? '0');
      final newMessageId = int.tryParse(message.id);

      // 새로운 메시지 ID와 기존 메시지 ID가 유효한 경우에만 처리
      if (newMessageId != null && latestMessageId != null) {
        if (latestMessageId >= newMessageId) {
          // 최신 메시지보다 이전 메시지라면 아무 작업도 하지 않음
          return;
        } else {
          // 새로운 메시지가 최신 메시지인 경우
          state = LoadedState(
            room: pState.room,
            messages: [message, ...messages],
          );
        }
      }
    }
  }

  Future<void> fetchRoom() async {
    final pState = state;

    if (pState is! LoadedState) return;

    try {
      final room = await roomsRepository.readRoom(roomId);

      state = LoadedState(
        room: room,
        messages: pState.messages,
      );
    } catch (e) {
      print('chat viewModel fetchRoom error $e');
    }
  }

  Future<void> updateChatMessages(List<TopicUiModel> topics) async {
    for (var topic in topics) {
      minTopicId = minTopicId > topic.topicId ? topic.topicId : minTopicId;
      maxTopicId = maxTopicId < topic.topicId ? topic.topicId : maxTopicId;
    }
    await readAllMessages(topics);
  }

  Future<void> readAllMessages(List<TopicUiModel> topics) async {
    for (var e in topics) {
      if (!e.readUsers.contains(auth.userId)) {
        await sendReceiveMessage(e);
      }
    }
  }
}

sealed class State {
  RoomUiModel? get room;

  List<types.Message> get messages;
}

class InitState extends State {
  @override
  final RoomUiModel? room = null;

  @override
  final List<types.Message> messages = [];
}

class LoadedState extends State {
  @override
  final RoomUiModel room;
  @override
  final List<types.Message> messages;

  LoadedState({
    required this.room,
    required this.messages,
  });
}

class ErrorState extends State {
  @override
  final RoomUiModel? room = null;

  @override
  final List<types.Message> messages = [];
  final String error;

  ErrorState({
    required this.error,
  });
}
