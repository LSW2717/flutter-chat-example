import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_example/domain/repository/rooms_repository.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/auth/auth_state_provider.dart';
import '../../../domain/ui_model/friend_ui_model.dart';
import '../../../domain/ui_model/room_ui_model.dart';

part 'view_model.g.dart';

@riverpod
class ViewModel extends _$ViewModel {
  @protected
  late RoomsRepository roomsRepository;

  @protected
  late AuthState auth;

  String? get _userId => auth.userId;

  @override
  State build() {
    roomsRepository = ref.watch(roomsRepositoryProvider);
    auth = ref.read(authProvider);
    getAllRooms();
    return InitState();
  }

  Future<void> getAllRooms() async {
    try {
      final rooms = await roomsRepository.getAllRooms(
        userId: _userId ?? "",
      );

      state = LoadedState(rooms: rooms.embedded.rooms);
    } catch (e) {
      state = ErrorState(error: e.toString());
    }
  }
}

sealed class State {}

class InitState extends State {}

class LoadedState extends State {
  final List<RoomUiModel> rooms;

  LoadedState({
    required this.rooms,
  });
}

class ErrorState extends State {
  final String error;

  ErrorState({
    required this.error,
  });
}
