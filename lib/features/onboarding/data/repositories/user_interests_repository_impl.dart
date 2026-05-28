import 'package:experience_app/features/onboarding/data/data_sources/user_interests_data_source.dart';
import 'package:experience_app/features/onboarding/domain/entities/user_interests_entity.dart';
import 'package:experience_app/features/onboarding/domain/repositories/user_interests_repository.dart';

class UserInterestsRepositoryImpl extends UserInterestsRepository {
  final InterestsDataSource _dataSource;

  UserInterestsRepositoryImpl({
    InterestsDataSource? dataSource,
  }) : _dataSource = dataSource ?? InterestsDataSource();

  @override
  Future<List<UserInterests>> getUserInterests() async {
    final userInterests = await _dataSource.getUserInterests();
    return userInterests.map((model) => UserInterests.fromModel(model)).toList();
  }

  @override
  Future<void> saveUserInterests(List<UserInterests> interests) async {
    final userInterests = interests;
    final userInterestsModels = userInterests.map((e) => e.toModel()).toList();
    await _dataSource.saveUserInterests(userInterestsModels);
  }
}