import 'package:flutter_chat_example/data/local/user/source/user_local_data_source.dart';
import 'package:flutter_chat_example/data/remote/users/model/user_model.dart';
import 'package:flutter_chat_example/domain/converter/user_converter.dart';
import 'package:flutter_chat_example/domain/ui_model/user_ui_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/remote/users/api/users_api.dart';

part 'users_repository.g.dart';

@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) {
  final usersApi = ref.watch(usersApiProvider);
  final local = ref.watch(userLocalDataSourceProvider);
  return UsersRepository(
    usersApi: usersApi,
    local: local,
  );
}

class UsersRepository {
  final UsersApi usersApi;
  final UserLocalDataSource local;

  UsersRepository({
    required this.usersApi,
    required this.local,
  });

  Future<UserUiModel> createUser({required String userName}) async {
    try {
      final createUser = UserModel(userName: userName);
      final user = await usersApi.create(createUser);

      //local 에도 user 등록
      local.create(
        userId: user.userId ?? "",
        userName: user.userName ?? "",
      );

      return UserConverter.toUiModel(user);
    } catch (e) {
      throw "createUser 호출 중 에러 $e";
    }
  }

  Future<UserUiModel?> readUser(String userId) async {
    try {
      final user = await usersApi.read(userId);
      return UserConverter.toUiModel(user);
    } catch (e) {
      print('readUser 호출 중 에러 $e');
      rethrow;
    }
  }

  Future<UserUiModel?> checkUser() async {
    try {
      final currentUser = local.read();

      if(currentUser == null) return null;

      final user = await usersApi.read(currentUser.userId);
      return UserConverter.toUiModel(user);
    }catch(e){
      print('checkUser 호출 중 에러 $e');
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      final currentUser = local.read();

      if(currentUser == null) return;

      await usersApi.delete(currentUser.userId);

      local.delete();
    }catch(e){
      throw "deleteUser 호출 중 에러 $e";
    }
  }
}
