// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModel<T> _$CollectionModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CollectionModel<T>(
      embedded: fromJsonT(json['_embedded']),
      page: PageModel.fromJson(json['page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionModelToJson<T>(
  CollectionModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      '_embedded': toJsonT(instance.embedded),
      'page': instance.page.toJson(),
    };
