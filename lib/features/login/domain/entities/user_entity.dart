import 'package:experience_app/features/login/domain/enums/rol.dart';
class UserEntity {
  final String userName;
  final String name;
  final String email;
  final Role role;

  UserEntity({
    required this.userName,
    required this.name,
    required this.email,
    required this.role,
  });
}