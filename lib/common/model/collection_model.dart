import 'package:flutter_chat_example/common/model/page_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_model.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class CollectionModel<T> {

  @JsonKey(name: "_embedded")
  final T embedded;

  final PageModel page;

  CollectionModel({
    required this.embedded,
    required this.page,
  });

  factory CollectionModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CollectionModelFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$CollectionModelToJson<T>(this, toJsonT);
}
