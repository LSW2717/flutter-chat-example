import 'package:dio/dio.dart';
import 'package:flutter_chat_example/common/const/data.dart';
import 'package:flutter_chat_example/common/dio/dio.dart';
import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/room_model.dart';

part 'rooms_api.g.dart';

@Riverpod(keepAlive: true)
RoomsApi roomsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return RoomsApi(dio, baseUrl: '$BACKEND_APi_URL/rooms');
}

@RestApi()
abstract class RoomsApi {
  factory RoomsApi(Dio dio, {String baseUrl}) = _RoomsApi;

  @GET('/{id}')
  Future<RoomModel> read(@Path('id') String id);

  @POST('/search')
  Future<CollectionModel<RoomsModel>> search({
    @Body() required RoomModel data,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sort') List<String>? sort,
  });
}
