import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../common/const/typography.dart';
import '../../../common/layout/shell_view.dart';
import '../../../common/router/routes/route/rooms_route.dart';
import '../../../common/utils/date.dart';
import '../../../common/widget/alert.dart';
import '../../../common/widget/custom_divider.dart';
import '../../../data/remote/rooms/model/room_model.dart';
import '../../../domain/ui_model/room_ui_model.dart';
import 'component/rooms_avatar.dart';
import 'view_model.dart' as rooms;

class View extends ConsumerStatefulWidget implements ShellView {
  const View({super.key});

  @override
  AppBar appBar(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context);
    return AppBar(
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Text(text?.rooms ?? ""),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  BottomNavigationBarItem navItem(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context);
    return BottomNavigationBarItem(
      icon: const Icon(Icons.chat),
      label: text?.rooms,
    );
  }

  @override
  Future<void> onTap(WidgetRef ref) async {
    await ref.read(rooms.viewModelProvider.notifier).getAllRooms();
  }

  @override
  ConsumerState<View> createState() => _ViewState();
}

class _ViewState extends ConsumerState<View> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: Platform.isIOS
          ? const BouncingScrollPhysics()
          : const ClampingScrollPhysics(),
      slivers: [
        Builder(builder: (context) {
          final roomsState = ref.watch(rooms.viewModelProvider);
          switch (roomsState) {
            case rooms.LoadedState():
              final roomsData = roomsState.rooms;
              return roomsData.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text(
                          '채팅방이 없습니다.',
                          style: text14.copyWith(color: Colors.grey[600]),
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ...roomsData.map((room) {
                            return InkWell(
                              onTap: () async {
                                context.push(RoomsRoute.chatKey(room.roomId));
                              },
                              child: _buildRoomCard(room),
                            );
                          }),
                        ],
                      ),
                    );
            case rooms.InitState():
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case rooms.ErrorState():
              final error = roomsState.error;
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    error,
                    style: text18,
                  ),
                ),
              );
          }
        }),
      ],
    );
  }

  Widget _buildRoomCard(RoomUiModel room) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;
    double actionRatio = 88 /
        (orientation == Orientation.portrait ? screenWidth : screenWidth - 78);
    List<RoomMemberUiModel> members = room.roomMembers
        .where((member) => member.type != RoomMemberType.ME)
        .toList();
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: actionRatio,
        motion: const ScrollMotion(),
        children: [
          _deleteSlidableAction(context, ref, room.roomId),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RoomsAvatar(members: members),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 200,
                              ),
                              child: Text(
                                room.roomName,
                                style: text16.copyWith(color: Colors.grey[800]),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 200,
                          ),
                          child: Text(
                            room.channel.lastTopic.content.text ?? "",
                            maxLines: 1,
                            style: text14.copyWith(
                              color: Colors.grey[600],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTopicTime(room.channel.lastTopic.topicId),
                      style: text12.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    room.roomBadge > 0
                        ? Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                '${room.roomBadge}',
                                style: text12.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        : const SizedBox(height: 22),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          const CustomDivider(),
        ],
      ),
    );
  }

  CustomSlidableAction _deleteSlidableAction(
      BuildContext context, WidgetRef ref, String id) {
    return CustomSlidableAction(
      onPressed: (_) async {
        await alert(
          context,
          () async {},
          '채팅방 나가기',
          '채팅방을 나가시겠습니까?',
          "채팅방 나가기에 실패했습니다",
        );
      },
      padding: EdgeInsets.zero,
      backgroundColor: Colors.red,
      child: Container(
        width: 82,
        height: 82,
        alignment: Alignment.center,
        child: const Icon(Icons.output),
      ),
    );
  }
}
