import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  int id = 0;
  String userId;
  String userName;

  UserEntity({
    required this.userId,
    required this.userName,
  });
}
