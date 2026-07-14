import 'package:experience_app/features/login/domain/use_cases/login.dart';
import 'package:experience_app/features/login/presentation/state/login_state.dart';
import 'package:riverpod/legacy.dart';

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);


class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginNotifier({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ?? LoginUseCase(),
        super(LoginInitialState()) ;

  Future<void> login(String email, String password) async {
    state = LoginLoadingState(email, password, null);
    try {
      final user = await _loginUseCase.call(email, password);
      state = LoginSuccessState(email, password, user.role);
    } catch (e) {
      print('Error en login: $e');
    }
  }


}