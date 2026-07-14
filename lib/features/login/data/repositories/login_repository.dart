import 'package:experience_app/features/login/data/data_sources/login_data_souce.dart';
import 'package:experience_app/features/login/data/models/login_credentials_model.dart';
import 'package:experience_app/features/login/domain/entities/user_entity.dart';
import 'package:experience_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _dataSource;
  LoginRepositoryImpl({LoginDataSource? dataSource})
      : _dataSource = dataSource ?? LoginDataSource();


  @override
  Future<UserEntity> login(String email, String password) async {
    final userLogin = await _dataSource.login(LoginRequestModel(email: email, password: password));
    final response = UserEntity.fromModel(userLogin);
    return response;
  }

}