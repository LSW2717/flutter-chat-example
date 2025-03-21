import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../secure_storage/secure_storage.dart';

part 'dio.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(
    CustomInterceptor(
      storage: storage,
      ref: ref,
    ),
  );
  dio.options = BaseOptions(
    sendTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status != null && status >= 200 && status < 300;
    },
  );
  return dio;
}

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      print('[REQ] [${options.method}] ${options.uri}');
    }
    // if (options.headers['accessToken'] == 'true') {
    //   options.headers.remove('accessToken');
    //   final token = await storage.read(key: KEY_JWT_ID_TOKEN);
    //   options.headers.addAll({
    //     'Authorization': 'Bearer $token',
    //   });
    // }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      print(
      '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}',
    );
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    handler.next(err);
  }
}
