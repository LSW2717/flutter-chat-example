import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_example/data/ws/stomp_base.dart';
import 'package:flutter_chat_example/data/ws/stomp_chat_send_model.dart';
import 'package:flutter_chat_example/domain/converter/topic_converter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/const/data.dart';
import '../../domain/ui_model/topic_ui_model.dart';
import '../remote/topics/model/topic_model.dart';

part 'stomp_chat.g.dart';

@riverpod
StompChat stompChat(Ref ref) {
  return StompChat();
}

class StompChat extends StompBase {

  String url = BACKEND_SOCKET_URL;

  late String channelId;

  late String userId;


  Future<StompBase> join({
    required String channelId,
    required String userId,
    required ValueChanged<TopicUiModel> onReceived,
  }) async {
    this.channelId = channelId;
    this.userId = userId;

    final connectUrl = url;

    return super.connect(
      url: connectUrl,
      onConnect: (frame) {
        super.subscribe(
          destination: '/topic/chat.$channelId',
          payloadCallBack: (frame) {
            TopicModel message = TopicModel.fromJson(jsonDecode(frame.body ?? "{}"));
            onReceived(TopicConverter.toUiModel(message));
          },
        );
      },
    );
  }

  /// 유저 입력 채팅 메시지 전송
  Future<void> sendMessage(StompChatSendModel message) async {
    try {
      final destination = '/app/chat.$channelId';
      final body = jsonEncode(message);


      debugPrint(
          '✅ sendMessage : \ndestination : $destination \n>> body \n${prettyJson(message)}');


      await super.broadcast(destination: destination, payload: body);
    } catch (e) {
      debugPrint('sendMessage error : $e');
      rethrow;
    }
  }
}
