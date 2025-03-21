import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/auth/auth_state_provider.dart';
import 'package:flutter_chat_example/common/widget/avatar.dart';
import 'package:flutter_chat_example/common/widget/custom_divider.dart';
import 'package:flutter_chat_example/domain/ui_model/friend_ui_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../common/const/typography.dart';
import '../../../common/router/routes/route/rooms_route.dart';
import 'view_model.dart' as friends;
import '../../../common/layout/shell_view.dart';

class View extends ConsumerStatefulWidget implements ShellView {
  const View({
    super.key,
  });

  @override
  AppBar appBar(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context);
    return AppBar(
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Text(text?.friends ?? ""),
        ],
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
            },
            icon: const Icon(Icons.output)),
        const Gap(2),
      ],
    );
  }

  @override
  BottomNavigationBarItem navItem(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context);
    return BottomNavigationBarItem(
      icon: const Icon(Icons.person),
      label: text?.friends,
    );
  }

  @override
  Future<void> onTap(WidgetRef ref) async {
    await ref.read(friends.viewModelProvider.notifier).getAllFriends();
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
        SliverToBoxAdapter(
          child: Column(
            children: [
              InkWell(
                onTap: null,
                child: _buildMyCard(),
              ),
              const CustomDivider(),
            ],
          ),
        ),
        Builder(builder: (context) {
          final friendsState = ref.watch(friends.viewModelProvider);
          switch (friendsState) {
            case friends.LoadedState():
              final myFriends = friendsState.friends;
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Text(
                            '친구(${myFriends.length}명)',
                            style: text16,
                          ),
                        ),
                      ],
                    ),
                    if (myFriends.isNotEmpty)
                      ...myFriends.map((friend) {
                        return InkWell(
                          onTap: () async {
                            await ref
                                .read(friends.viewModelProvider.notifier)
                                .createRoom(friend)
                                .then((room) {
                              if (room != null) {
                                context.push(RoomsRoute.chatKey(room.roomId));
                              }
                            });
                          },
                          child: _buildFriendCard(friend),
                        );
                      }),
                    if (myFriends.isEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: Text(
                            '친구가 없습니다.',
                            style: text14.copyWith(color: Colors.grey[600]),
                          ),
                        ),
                      )
                  ],
                ),
              );
            case friends.InitState():
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case friends.ErrorState():
              final error = friendsState.error;
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

  Widget _buildMyCard() {
    final auth = ref.watch(authProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Avatar(
            avatarUrl: '',
            avatarSize: 80,
          ),
          const Gap(16),
          Text(
            auth.userName ?? "",
            style: text22,
          ),
        ],
      ),
    );
  }

  Widget _buildFriendCard(FriendUiModel friend) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Row(
        children: [
          const Avatar(
            avatarUrl: '',
            avatarSize: 50,
          ),
          const Gap(16),
          Text(
            friend.friend.userName,
            style: text18,
          ),
        ],
      ),
    );
  }
}
