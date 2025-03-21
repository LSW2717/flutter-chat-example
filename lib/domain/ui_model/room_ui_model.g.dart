// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomUiModel _$RoomUiModelFromJson(Map<String, dynamic> json) => RoomUiModel(
      roomId: json['roomId'] as String,
      userId: json['userId'] as String,
      channel: ChannelUiModel.fromJson(json['channel'] as Map<String, dynamic>),
      roomBadge: (json['roomBadge'] as num).toInt(),
      roomActive: json['roomActive'] as bool,
      roomType: json['roomType'] as String,
      firstTopic:
          TopicUiModel.fromJson(json['firstTopic'] as Map<String, dynamic>),
      roomNameRef: json['roomNameRef'] as String,
      roomName: json['roomName'] as String,
      roomMembers: (json['roomMembers'] as List<dynamic>)
          .map((e) => RoomMemberUiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomUiModelToJson(RoomUiModel instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'userId': instance.userId,
      'channel': instance.channel,
      'roomBadge': instance.roomBadge,
      'roomActive': instance.roomActive,
      'roomType': instance.roomType,
      'firstTopic': instance.firstTopic,
      'roomNameRef': instance.roomNameRef,
      'roomName': instance.roomName,
      'roomMembers': instance.roomMembers,
    };

RoomsUiModel _$RoomsUiModelFromJson(Map<String, dynamic> json) => RoomsUiModel(
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => RoomUiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomsUiModelToJson(RoomsUiModel instance) =>
    <String, dynamic>{
      'rooms': instance.rooms,
    };

RoomMemberUiModel _$RoomMemberUiModelFromJson(Map<String, dynamic> json) =>
    RoomMemberUiModel(
      type: $enumDecode(_$RoomMemberTypeEnumMap, json['type']),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$RoomMemberUiModelToJson(RoomMemberUiModel instance) =>
    <String, dynamic>{
      'type': _$RoomMemberTypeEnumMap[instance.type]!,
      'userId': instance.userId,
      'userName': instance.userName,
    };

const _$RoomMemberTypeEnumMap = {
  RoomMemberType.NEIGHBOR: 'NEIGHBOR',
  RoomMemberType.FRIEND: 'FRIEND',
  RoomMemberType.STRANGER: 'STRANGER',
  RoomMemberType.ME: 'ME',
};
