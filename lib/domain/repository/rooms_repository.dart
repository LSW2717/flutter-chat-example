import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_chat_example/data/remote/channels/api/channels_api.dart';
import 'package:flutter_chat_example/data/remote/channels/model/channel_model.dart';
import 'package:flutter_chat_example/data/remote/rooms/model/room_model.dart';
import 'package:flutter_chat_example/data/remote/topics/api/topics_api.dart';
import 'package:flutter_chat_example/data/remote/topics/model/topic_model.dart';
import 'package:flutter_chat_example/domain/converter/room_converter.dart';
import 'package:flutter_chat_example/domain/ui_model/friend_ui_model.dart';
import 'package:flutter_chat_example/domain/ui_model/room_ui_model.dart';
import 'package:flutter_chat_example/domain/ui_model/topic_ui_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/remote/rooms/api/rooms_api.dart';
import '../converter/topic_converter.dart';

part 'rooms_repository.g.dart';

@Riverpod(keepAlive: true)
RoomsRepository roomsRepository(Ref ref) {
  final roomsApi = ref.watch(roomsApiProvider);
  final channelsApi = ref.watch(channelsApiProvider);
  final topicsApi = ref.watch(topicsApiProvider);
  return RoomsRepository(
    roomsApi: roomsApi,
    channelsApi: channelsApi,
    topicsApi: topicsApi,
  );
}

class RoomsRepository {
  final RoomsApi roomsApi;
  final ChannelsApi channelsApi;
  final TopicsApi topicsApi;

  RoomsRepository({
    required this.roomsApi,
    required this.channelsApi,
    required this.topicsApi,
  });

  Future<RoomUiModel> readRoom(String roomId) async {
    try {
      final room = await roomsApi.read(roomId);

      printPrettyJson(room.roomMembers);
      return RoomConverter.toUiModel(room);
    } catch (e) {
      print('readRoom 호출 중 에러 $e');
      rethrow;
    }
  }

  Future<CollectionModel<RoomsUiModel>> getAllRooms({
    required String userId,
    int? page,
  }) async {
    try {
      final rooms = await roomsApi.search(
        data: RoomModel(userId: userId),
        page: page,
      );
      return RoomConverter.toUiModelList(rooms);
    } catch (e) {
      print('getAllRooms 호출 중 에러 $e');
      rethrow;
    }
  }

  Future<RoomUiModel> createRoom({
    required List<FriendUiModel> friends,
    required String userId,
  }) async {
    try {
      List<String> inviteUsers = [];
      List<String> roomName = [];

      for (var friend in friends) {
        inviteUsers.add(friend.friend.userId);
        roomName.add(friend.friend.userName);
      }

      final channel = await channelsApi.search(
        body: ChannelModel(
          inviteUsers: inviteUsers,
          channelOwner: userId,
          channelName: roomName.toString(),
        ),
      );

      final res = channel.embedded.channels.firstOrNull;

      if (res == null) {
        return Future.error('채널이 없습니다.');
      }
      final roomId = '$userId-${res.channelId}';

      final room = await roomsApi.read(roomId);

      return RoomConverter.toUiModel(room);
    } catch (e) {
      print('createRoom 호출 중 에러 $e');
      rethrow;
    }
  }

  Future<CollectionModel<TopicsUiModel>> searchTopics({
    required String channelId,
    int? searchMinTopicId,
    int? searchMaxTopicId,
    int? page,
  }) async {
    try {
      final topics = await topicsApi.search(
          data: TopicModel(
        searchChannelId: channelId,
        searchMaxTopicId: searchMaxTopicId,
        searchMinTopicId: searchMinTopicId,
      ));

      return TopicConverter.toUiModelList(topics);
    } catch (e) {
      print('searchTopics 호출 중 에러 $e');
      rethrow;
    }
  }
}
