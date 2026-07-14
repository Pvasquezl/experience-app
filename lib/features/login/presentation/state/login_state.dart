import 'package:experience_app/features/login/domain/entities/user_entity.dart';

abstract class LoginState {
  final String email;
  final String password;
  final Role? role;

  LoginState(this.email, this.password, this.role);
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super('', '', null);
}

class LoginLoadingState extends LoginState {
  LoginLoadingState(super.email, super.password, super.userId);
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(super.email, super.password, super.userId);
}