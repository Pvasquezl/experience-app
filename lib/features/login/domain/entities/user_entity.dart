import 'package:experience_app/features/login/data/models/user_model.dart';

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

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      userName: model.userName,
      name: model.name,
      email: model.email,
      role: model.role.toRole(),
    );
  }
}

enum Role {
  admin,
  customer
}

extension on String {
  Role toRole() {
    switch (this) {
      case 'admin':
        return Role.admin;
      case 'customer':
        return Role.customer;
      default:
        throw Exception('Invalid role: $this');
    }
  }
}