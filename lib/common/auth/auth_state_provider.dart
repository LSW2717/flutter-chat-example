import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_example/domain/repository/users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/remote/users/model/user_model.dart';
import '../../domain/ui_model/user_ui_model.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @protected
  late UsersRepository usersRepository;

  @override
  AuthState build() {
    usersRepository = ref.watch(usersRepositoryProvider);
    getMe();
    return AuthState();
  }

  Future<void> getMe() async {
    try {
      final user = await usersRepository.checkUser();

      state = AuthState(
        userId: user?.userId,
        userName: user?.userName,
      );
    } catch (e) {
      state = AuthState();
    }
  }

  void setUser(UserUiModel? user) async {
    if (user == null) return;

    state = AuthState(
      userId: user.userId,
      userName: user.userName,
    );
  }

  Future<void> logout() async {
    try {
      await usersRepository.deleteUser();
      state = AuthState();
    } catch (e) {
      state = AuthState();
    }
  }
}

class AuthState {
  final String? userId;
  final String? userName;

  AuthState({
    this.userId,
    this.userName,
  });

  bool get isLogin => userId != null;
}
