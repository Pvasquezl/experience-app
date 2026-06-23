abstract class LoginState {
  final String email;
  final String password;
  final String? userId;

  LoginState(this.email, this.password, this.userId);
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