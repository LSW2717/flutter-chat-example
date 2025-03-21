import 'package:dio/dio.dart';
import 'package:flutter_chat_example/common/const/data.dart';
import 'package:flutter_chat_example/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/model/collection_model.dart';
import '../model/topic_model.dart';

part 'topics_api.g.dart';

@Riverpod(keepAlive: true)
TopicsApi topicsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return TopicsApi(dio, baseUrl: '$BACKEND_APi_URL/topics');
}

@RestApi()
abstract class TopicsApi{
  factory TopicsApi(Dio dio, {String baseUrl}) = _TopicsApi;

  @POST('/search')
  Future<CollectionModel<TopicsModel>> search({
    @Body() required TopicModel data,
    @Queries() Map<String, dynamic>? params,
  });

}
