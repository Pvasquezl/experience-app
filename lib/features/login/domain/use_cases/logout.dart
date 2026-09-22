import 'package:experience_app/features/login/data/repositories/login_repository.dart';
import 'package:experience_app/features/login/domain/repositories/login_repository.dart';

class LogoutUseCase {
  final LoginRepository _loginRepository;
  LogoutUseCase({LoginRepository? loginRepository})
    : _loginRepository = loginRepository ?? LoginRepositoryImpl();

  Future<void> call() async {
    await _loginRepository.logout();
  }
}
