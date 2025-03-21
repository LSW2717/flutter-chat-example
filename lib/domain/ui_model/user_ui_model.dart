import 'package:json_annotation/json_annotation.dart';

part 'user_ui_model.g.dart';

@JsonSerializable()
class UserUiModel {
  final String userId;
  final String userName;
  UserUiModel({
    required this.userId,
    required this.userName,
  });

  factory UserUiModel.fromJson(Map<String, dynamic> json) => _$UserUiModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserUiModelToJson(this);
}
