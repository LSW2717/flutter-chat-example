import 'package:flutter/cupertino.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class StompBase {
  StompBase();

  StompClient? stompClient;

  bool isConnected() {
    if (stompClient == null) {
      return false;
    }
    return stompClient!.connected;
  }

  Future<StompBase> connect({
    required String url,
    String? destination,
    Map<String, String>? payload,
    ValueChanged<StompFrame>? onConnect,
  }) async {
    bool connected = false;

    final headers = payload;

    if (destination != null) {
      headers?["destination"] = destination;
    }

    stompClient = StompClient(
      config: StompConfig(
        url: url,
        // stompConnectHeaders: headers,
        reconnectDelay: const Duration(seconds: 1),
        connectionTimeout: const Duration(seconds: 1),
        onConnect: (frame) async {
          connected = true;
          if(onConnect != null){
            onConnect(frame);
          }
        },
        heartbeatOutgoing: const Duration(seconds: 10),
        heartbeatIncoming: const Duration(seconds: 10),
        onDisconnect: onDisconnect,
        onStompError: onStompError,
        onWebSocketDone: onWebSocketDone,
        onWebSocketError: onWebSocketError,
      ),
    );

    stompClient?.activate();

    await Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 100));
      if (connected) {
        return false;
      } else {
        return true;
      }
    });

    return Future.value(this);
  }

  Future<StompBase> broadcast({
    required String destination,
    required String payload,
    String? sessionEventType,
  }) {
    return Future(() {
      // if (!isConnected()) throw this;

      Map<String, String> headers = sessionEventType == null
          ? {}
          : {'sessionEventType': sessionEventType};

      try {
        stompClient?.send(
          destination: destination,
          headers: headers,
          body: payload,
        );
        return this;
      } catch (e) {
        print(e);
        rethrow;
      }
    });
  }

  Future<StompBase> subscribe({
    required String destination,
    required StompFrameCallback payloadCallBack,
    Map<String, String>? headers,
  }) {
    return Future(() {
      stompClient?.subscribe(
        destination: destination,
        callback: payloadCallBack,
        headers: headers,
      );
      return this;
    });
  }

  Future<StompBase> disconnect() {
    return Future(() {
      if (stompClient != null && stompClient!.connected) {
        stompClient!.deactivate();
        print('✅ WebSocket connection deactivated');
      } else {
        print('⚠️ WebSocket already disconnected or not initialized');
      }
      stompClient = null;
      return this;
    });
  }

  void onDisconnect(StompFrame frame) {
    print("StompClient disconnected");
  }

  void onWebSocketError(dynamic error) {
    print("WebSocket error: $error");
  }

  void onStompError(StompFrame frame) {
    print("Stomp error: ${frame.body}");
  }

  void onWebSocketDone() {
    print("WebSocket connection closed");
  }
}
