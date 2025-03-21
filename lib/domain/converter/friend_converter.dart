import 'package:flutter_chat_example/common/model/collection_model.dart';
import 'package:flutter_chat_example/domain/converter/user_converter.dart';

import '../../data/remote/friends/model/friend_model.dart';
import '../../data/remote/users/model/user_model.dart';
import '../ui_model/friend_ui_model.dart';

class FriendConverter {
  static FriendUiModel toUiModel(FriendModel friend) {
    return FriendUiModel(
      friendId: friend.friendId ?? "",
      userId: friend.userId ?? "",
      friendName: friend.friendName ?? "",
      friend: UserConverter.toUiModel(friend.friend ?? UserModel()),
    );
  }

  static CollectionModel<FriendsUiModel> toUiModelList(
      CollectionModel<FriendsModel> friends) {
    return CollectionModel<FriendsUiModel>(
      embedded: FriendsUiModel(
        friends: friends.embedded.friends.map(toUiModel).toList(),
      ),
      page: friends.page,
    );
  }
}
