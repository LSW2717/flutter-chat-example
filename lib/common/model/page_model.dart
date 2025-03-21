import 'package:json_annotation/json_annotation.dart';

part 'page_model.g.dart';

@JsonSerializable()
class PageModel {
  final int size;
  final int totalElements;
  final int totalPages;
  final int number;

  PageModel({
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.number,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageModelToJson(this);
}
