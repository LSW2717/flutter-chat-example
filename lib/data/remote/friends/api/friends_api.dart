import'package:dio/dio.dart';
import 'package:flutter_chat_example/common/const/data.dart';
import 'package:flutter_chat_example/common/dio/dio.dart';
import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/friend_model.dart';

part 'friends_api.g.dart';

@Riverpod(keepAlive: true)
FriendsApi friendsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FriendsApi(dio, baseUrl: '$BACKEND_APi_URL/friends');
}

@RestApi()
abstract class FriendsApi {
  factory FriendsApi(Dio dio, {String baseUrl}) = _FriendsApi;

  @GET('/{id}')
  Future<FriendModel> read(@Path('id') String id);

  @POST('/search')
  Future<CollectionModel<FriendsModel>> search({
    @Body() required FriendModel body,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sort') List<String>? sort,
  });
}
