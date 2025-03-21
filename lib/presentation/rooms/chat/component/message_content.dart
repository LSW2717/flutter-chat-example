import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/auth/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/const/typography.dart';
import '../../../../data/remote/topics/model/topic_model.dart';
import '../../../../domain/ui_model/room_ui_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageContent extends ConsumerWidget {
  final RoomUiModel room;
  final types.Message message;
  final int messageWidth;

  const MessageContent({
    required this.room,
    required this.message,
    required this.messageWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentJson = message.metadata?['content'];
    final content =
    contentJson != null ? ContentModel.fromJson(contentJson) : null;
    final auth = ref.watch(authProvider);
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: messageWidth.toDouble() - 132,
          ),
          child: Column(
            crossAxisAlignment: message.author.id == auth.userId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
                Text(
                  content?.text ?? "",
                  softWrap: true,
                  style: text14.copyWith(
                    color: message.author.id == auth.userId
                        ? Colors.white
                        : Colors.grey[800],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}