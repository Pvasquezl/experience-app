import 'package:experience_app/features/login/domain/entities/user_entity.dart';

abstract class LoginRepository {
  Future<UserEntity> login(String email, String password);
}