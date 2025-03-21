import 'package:dio/dio.dart';
import 'package:flutter_chat_example/common/const/data.dart';
import 'package:flutter_chat_example/common/dio/dio.dart';
import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/channel_model.dart';

part 'channels_api.g.dart';

@Riverpod(keepAlive: true)
ChannelsApi channelsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ChannelsApi(dio, baseUrl: '$BACKEND_APi_URL/channels');
}

@RestApi()
abstract class ChannelsApi {
  factory ChannelsApi(Dio dio, {String baseUrl}) = _ChannelsApi;

  @POST('/search')
  Future<CollectionModel<ChannelsModel>> search({
    @Body() required ChannelModel body,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sort') List<String>? sort,
  });
}
