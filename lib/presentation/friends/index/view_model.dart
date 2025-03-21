import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_example/data/ws/stomp_chat.dart';
import 'package:flutter_chat_example/domain/repository/friends_repository.dart';
import 'package:flutter_chat_example/domain/repository/rooms_repository.dart';
import 'package:flutter_chat_example/domain/ui_model/room_ui_model.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/auth/auth_state_provider.dart';
import '../../../data/ws/stomp_chat_send_model.dart';
import '../../../domain/ui_model/friend_ui_model.dart';

part 'view_model.g.dart';

@riverpod
class ViewModel extends _$ViewModel {
  @protected
  late FriendsRepository friendsRepository;

  @protected
  late RoomsRepository roomsRepository;

  @protected
  late StompChat stompChat;

  @protected
  late AuthState auth;

  String? get _userId => auth.userId;

  @override
  State build() {
    friendsRepository = ref.watch(friendsRepositoryProvider);
    roomsRepository = ref.watch(roomsRepositoryProvider);
    stompChat = ref.watch(stompChatProvider);
    auth = ref.read(authProvider);
    getAllFriends();
    return InitState();
  }

  Future<void> getAllFriends() async {
    try {
      final friends = await friendsRepository.getAllFriends(
        userId: _userId ?? "",
      );
      state = LoadedState(friends: friends.embedded.friends);
    } catch (e) {
      state = ErrorState(error: e.toString());
    }
  }

  Future<RoomUiModel?> createRoom(FriendUiModel friend) async {
    final List<FriendUiModel> inviteFriends = [];

    final pState = state;

    if (pState is! LoadedState) return null;

    inviteFriends.add(friend);

    try {
      final room = await roomsRepository.createRoom(
        friends: inviteFriends,
        userId: _userId ?? "",
      );
      return room;
    } catch (e) {
      print('createRoom 호출 중 에러 $e');
      return null;
    }
  }
}

sealed class State {}

class InitState extends State {}

class LoadedState extends State {
  final List<FriendUiModel> friends;

  LoadedState({
    required this.friends,
  });
}

class ErrorState extends State {
  final String error;

  ErrorState({
    required this.error,
  });
}
