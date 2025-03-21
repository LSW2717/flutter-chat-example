import 'package:flutter_chat_example/domain/ui_model/user_ui_model.dart';

import '../../data/remote/users/model/user_model.dart';

class UserConverter {
  static UserUiModel toUiModel(UserModel user) {
    return UserUiModel(
      userId: user.userId ?? "",
      userName: user.userName ?? "",
    );
  }
}
