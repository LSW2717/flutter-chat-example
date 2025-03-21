import 'package:flutter/material.dart';
import 'package:flutter_chat_example/common/auth/auth_state_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../common/const/typography.dart';
import 'component/message_bubble.dart';
import 'component/message_content.dart';
import 'view_model.dart' as chat;

class View extends ConsumerStatefulWidget {
  final String roomId;

  const View({
    required this.roomId,
    super.key,
  });

  @override
  ConsumerState<View> createState() => _ViewState();
}

class _ViewState extends ConsumerState<View> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final chatState = ref.watch(chat.viewModelProvider(widget.roomId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          chatState is chat.LoadedState ? chatState.room.roomName : '알수없음',
          style: text18,
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Builder(builder: (context) {
          final chatState = ref.watch(chat.viewModelProvider(widget.roomId));
          switch (chatState) {
            case chat.LoadedState():
              return Chat(
                messages: chatState.messages,
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
                onSendPressed: (text) async {
                  await ref
                      .read(chat.viewModelProvider(widget.roomId).notifier)
                      .sendMessage(text: text.text);
                },
                useTopSafeAreaInset: true,
                onEndReached: () async {
                  await ref
                      .read(chat.viewModelProvider(widget.roomId).notifier)
                      .loadMoreMessages();
                },
                onEndReachedThreshold: 0.1,
                user: types.User(
                  id: auth.userId.toString(),
                ),
                emptyState: const Center(
                  child: Text(
                    '',
                  ),
                ),
                customMessageBuilder: (
                  types.CustomMessage message, {
                  required int messageWidth,
                }) {
                  return MessageContent(
                    room: chatState.room,
                    message: message,
                    messageWidth: messageWidth,
                  );
                },
                bubbleBuilder: (
                  Widget child, {
                  required types.Message message,
                  required bool nextMessageInGroup,
                }) {
                  return MessageBubble(
                    room: chatState.room,
                    message: message,
                    child: child,
                  );
                },
                dateLocale: 'ko_KR',
                timeFormat: DateFormat('a h시 m분', 'ko_KR'),
                theme: DefaultChatTheme(
                  messageBorderRadius: 8,
                  primaryColor: Colors.lightBlue,
                  receivedMessageBodyTextStyle: text16,
                  dateDividerTextStyle: text12,
                  bubbleMargin: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 0,
                  ),
                ),
                systemMessageBuilder: (types.SystemMessage message) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200],
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        constraints: const BoxConstraints(
                          maxWidth: 250,
                        ),
                        child: Text(
                          message.text,
                          style: text12.copyWith(color: Colors.grey[700]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return Stack(
                children: [
                  Chat(
                    messages: const [],
                    onSendPressed: (text) {},
                    useTopSafeAreaInset: true,
                    onEndReachedThreshold: 0.1,
                    user: types.User(
                      id: auth.userId.toString(),
                    ),
                    emptyState: const Center(
                      child: Text(
                        '',
                      ),
                    ),
                    dateLocale: 'ko_KR',
                    timeFormat: DateFormat('a h시 m분', 'ko_KR'),
                  ),
                ],
              );
          }
        }),
      ),
    );
  }
}
