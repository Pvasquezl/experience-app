
import 'package:experience_app/features/login/data/repositories/login_repository.dart';
import 'package:experience_app/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;
  LoginUseCase({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepositoryImpl();

  Future<String> call(String email, String password) async {
    final response = await _loginRepository.login(email, password);
    return response;
  }
}