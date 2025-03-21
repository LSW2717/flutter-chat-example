import 'package:dio/dio.dart';
import 'package:flutter_chat_example/common/const/data.dart';
import 'package:flutter_chat_example/common/dio/dio.dart';
import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/user_model.dart';

part 'users_api.g.dart';

@Riverpod(keepAlive: true)
UsersApi usersApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return UsersApi(dio, baseUrl: '$BACKEND_APi_URL/users');
}

@RestApi()
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @POST('')
  Future<UserModel> create(@Body() UserModel body);

  @GET('/{id}')
  Future<UserModel> read(@Path('id') String id);

  @PUT('/{id}')
  Future<UserModel> update({
    @Path('id') required String id,
    @Body() required UserModel body,
  });

  @DELETE('/{id}')
  Future<UserModel?> delete(@Path('id') String id);

  @POST('/search')
  Future<CollectionModel<UsersModel>> search({
    @Body() required UserModel body,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sort') List<String>? sort,
  });
}
