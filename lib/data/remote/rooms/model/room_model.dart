import 'package:json_annotation/json_annotation.dart';

import '../../channels/model/channel_model.dart';
import '../../topics/model/topic_model.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String? roomId;
  final String? userId;
  final ChannelModel? channel;
  final int? roomBadge;
  final bool? roomActive;
  final String? roomType;
  final TopicModel? firstTopic;
  final String? roomNameRef;
  final String? roomName;
  final List<RoomMemberModel>? roomMembers;

  RoomModel({
    this.roomId,
    this.userId,
    this.channel,
    this.roomBadge,
    this.roomActive,
    this.roomType,
    this.firstTopic,
    this.roomNameRef,
    this.roomName,
    this.roomMembers,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => _$RoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}

@JsonSerializable()
class RoomsModel {
  final List<RoomModel> rooms;
  RoomsModel({
    required this.rooms,
  });

  factory RoomsModel.fromJson(Map<String, dynamic> json) => _$RoomsModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomsModelToJson(this);
}

@JsonSerializable()
class RoomMemberModel {
  final RoomMemberType type;
  final String? userId;
  final String? userName;

  RoomMemberModel({
    required this.type,
    this.userId,
    this.userName,
  });

  factory RoomMemberModel.fromJson(Map<String, dynamic> json) => _$RoomMemberModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomMemberModelToJson(this);
}

enum RoomMemberType {
  NEIGHBOR,
  FRIEND,
  STRANGER,
  ME;
}
