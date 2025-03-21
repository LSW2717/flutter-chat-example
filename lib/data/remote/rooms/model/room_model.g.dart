// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      roomId: json['roomId'] as String?,
      userId: json['userId'] as String?,
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
      roomBadge: (json['roomBadge'] as num?)?.toInt(),
      roomActive: json['roomActive'] as bool?,
      roomType: json['roomType'] as String?,
      firstTopic: json['firstTopic'] == null
          ? null
          : TopicModel.fromJson(json['firstTopic'] as Map<String, dynamic>),
      roomNameRef: json['roomNameRef'] as String?,
      roomName: json['roomName'] as String?,
      roomMembers: (json['roomMembers'] as List<dynamic>?)
          ?.map((e) => RoomMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
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

RoomsModel _$RoomsModelFromJson(Map<String, dynamic> json) => RoomsModel(
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomsModelToJson(RoomsModel instance) =>
    <String, dynamic>{
      'rooms': instance.rooms,
    };

RoomMemberModel _$RoomMemberModelFromJson(Map<String, dynamic> json) =>
    RoomMemberModel(
      type: $enumDecode(_$RoomMemberTypeEnumMap, json['type']),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$RoomMemberModelToJson(RoomMemberModel instance) =>
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
