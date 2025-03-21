import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_chat_example/domain/converter/channel_converter.dart';
import 'package:flutter_chat_example/domain/converter/topic_converter.dart';

import '../../data/remote/channels/model/channel_model.dart';
import '../../data/remote/rooms/model/room_model.dart';
import '../../data/remote/topics/model/topic_model.dart';
import '../ui_model/room_ui_model.dart';

class RoomConverter {
  static RoomUiModel toUiModel(RoomModel room) {
    return RoomUiModel(
      roomId: room.roomId ?? "",
      userId: room.userId ?? "",
      channel: ChannelConverter.toUiModel(room.channel ?? ChannelModel()),
      roomBadge: room.roomBadge ?? 0,
      roomActive: room.roomActive ?? false,
      roomType: room.roomType ?? "",
      firstTopic: TopicConverter.toUiModel(room.firstTopic ?? TopicModel()),
      roomNameRef: room.roomNameRef ?? "",
      roomName: room.roomName ?? room.roomNameRef ?? "알수없음",
      roomMembers: room.roomMembers?.map((member) {
        return RoomMemberUiModel(
          type: member.type,
          userId: member.userId ?? "",
          userName: member.userName ?? "",
        );
      }).toList() ?? [],
    );
  }

  static CollectionModel<RoomsUiModel> toUiModelList(
    CollectionModel<RoomsModel> rooms,
  ) {
    return CollectionModel<RoomsUiModel>(
      embedded: RoomsUiModel(
        rooms: rooms.embedded.rooms.map(toUiModel).toList(),
      ),
      page: rooms.page,
    );
  }
}
