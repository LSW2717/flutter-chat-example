import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/auth/auth_state_provider.dart';
import '../../../../common/const/typography.dart';
import '../../../../common/utils/date.dart';
import '../../../../common/widget/avatar.dart';
import '../../../../domain/ui_model/room_ui_model.dart';
import '../../../../presentation/rooms/chat/view_model.dart' as chat;

class MessageBubble extends ConsumerWidget {
  final Widget child;
  final RoomUiModel room;
  final types.Message message;

  const MessageBubble({
    required this.child,
    required this.room,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chat.viewModelProvider(room.roomId));
    final authState = ref.watch(authProvider);
    final int? totalUsers = chatState.room?.channel.inviteUsers.length;
    final int readMembersCount = (message.metadata?['readUsers'] as List?)?.length ?? 0;
    final int unreadMembersCount = totalUsers! - readMembersCount;
    return Row(
      mainAxisAlignment: message.author.id == authState.userId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 6),
          child: message.author.id != authState.userId &&
              _isFirstMessage(message, ref)
              ? const Avatar(
            avatarUrl: '',
            avatarSize: 40,
          )
              : const SizedBox(width: 40),
        ),
        Column(
          crossAxisAlignment: message.author.id == authState.userId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            message.author.id != authState.userId &&
                _isFirstMessage(message, ref)
                ? Container(
              constraints: const BoxConstraints(
                maxWidth: 100,
              ),
              child: Text(
                message.author.firstName!,
                overflow: TextOverflow.ellipsis,
                style: text14,
              ),
            )
                : const SizedBox.shrink(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (message.author.id == authState.userId)
                  _buildUnreadCountAndTime(
                      unreadMembersCount, message, false, ref),
                _isFirstMessage(message, ref)
                    ? ChatBubble(
                  clipper: ChatBubbleClipper8(
                      radius: 12,
                      type: message.author.id == authState.userId
                          ? BubbleType.sendBubble
                          : BubbleType.receiverBubble),
                  padding: message.author.id == authState.userId
                      ? const EdgeInsets.only(
                      top: 7, bottom: 7, left: 10, right: 13)
                      : const EdgeInsets.only(
                      top: 7, bottom: 7, left: 13, right: 10),
                  backGroundColor: message.author.id == authState.userId
                      ? Colors.lightBlue
                      : Colors.grey[100],
                  margin: const EdgeInsets.only(top: 2),
                  alignment: Alignment.topLeft,
                  elevation: 0,
                  child: child,
                )
                    : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: message.author.id == authState.userId
                        ? Colors.lightBlue
                        : Colors.grey[100],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 7),
                  margin: message.author.id == authState.userId
                      ? const EdgeInsets.only(right: 3, top: 2)
                      : const EdgeInsets.only(left: 3, top: 2),
                  child: child,
                ),
                if (message.author.id != authState.userId)
                  _buildUnreadCountAndTime(
                      unreadMembersCount, message, true, ref),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUnreadCountAndTime(
      int unreadCount,
      types.Message message,
      bool isMe,
      WidgetRef ref,
      ) {

    return Container(
      margin: isMe
          ? const EdgeInsets.only(left: 4)
          : const EdgeInsets.only(right: 4),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          unreadCount <= 0
              ? const Text('')
              : Text('$unreadCount', style: text12),
          if (_isLastMessage(message, ref))
            Text(
              formatTopic(
                int.parse(message.id),
              ),
              style: text10,
            ),
        ],
      ),
    );
  }

  bool _isFirstMessage(types.Message message, WidgetRef ref) {
    final chatState = ref.watch(chat.viewModelProvider(room.roomId));
    final messages = chatState.messages;

    int messageIndex =
    chatState.messages.indexWhere((msg) => msg.id == message.id);

    bool hasNextMessage = messageIndex + 1 < messages.length;

    if (hasNextMessage) {
      final nextMessage = messages[messageIndex + 1];
      DateTime messageTime =
      DateTime.fromMillisecondsSinceEpoch(message.createdAt ?? 0);
      DateTime nextMessageTime =
      DateTime.fromMillisecondsSinceEpoch(nextMessage.createdAt ?? 0);
      if (nextMessage is types.SystemMessage ||
          nextMessage.author.id != message.author.id ||
          (nextMessageTime.minute != messageTime.minute)) {
        return true;
      }
    }
    return false;
  }

  bool _isLastMessage(types.Message message, WidgetRef ref) {
    final chatState = ref.watch(chat.viewModelProvider(room.roomId));
    final messages = chatState.messages;
    int messageIndex =
    chatState.messages.indexWhere((msg) => msg.id == message.id);

    if (messageIndex == 0) {
      return true;
    }

    bool hasPreviousMessage = messageIndex - 1 >= 0;
    if (hasPreviousMessage) {
      final previousMessage = messages[messageIndex - 1];
      DateTime messageTime =
      DateTime.fromMillisecondsSinceEpoch(message.createdAt ?? 0);
      DateTime previousMessageTime =
      DateTime.fromMillisecondsSinceEpoch(previousMessage.createdAt ?? 0);

      if (previousMessage is types.SystemMessage ||
          previousMessage.author.id != message.author.id ||
          (previousMessageTime.minute != messageTime.minute)) {
        return true;
      }
    }
    return false;
  }
}
