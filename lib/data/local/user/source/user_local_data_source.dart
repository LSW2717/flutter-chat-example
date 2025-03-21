import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../main_initializer.dart';
import '../../../../objectbox.g.dart';
import '../model/user_entity.dart';

part 'user_local_data_source.g.dart';


@Riverpod(keepAlive: true)
UserLocalDataSource userLocalDataSource(Ref ref) {
  final local = store.box<UserEntity>();
  return UserLocalDataSource(local: local);
}

class UserLocalDataSource {
  final Box<UserEntity> local;

  UserLocalDataSource({
    required this.local,
  });

  void create({
    required String userId,
    required String userName,
  }) {
    final currentUser = local.getAll();

    if(currentUser.length != 1){
      local.removeAll();
    }

    final user = UserEntity(
      userId: userId,
      userName: userName,
    );
    local.put(user);
  }

  UserEntity? read(){
    final user = local.getAll();
    print(user);
    if(user.isEmpty){
      return null;
    }else{
      return user[0];
    }
  }

  void delete(){
    local.removeAll();
  }
}
