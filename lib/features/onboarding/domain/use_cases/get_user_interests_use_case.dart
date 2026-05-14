import 'package:experience_app/features/onboarding/data/repositories/user_interests_repository_impl.dart';
import 'package:experience_app/features/onboarding/domain/entities/user_interests_entity.dart';
import 'package:experience_app/features/onboarding/domain/repositories/user_interests_repository.dart';

class GetUserInterestsUseCase {
  final UserInterestsRepository _repository;
  GetUserInterestsUseCase({UserInterestsRepository? repository})
    : _repository = repository ?? UserInterestsRepositoryImpl();

    Future<List<UserInterests>> call() async {
        final interests = await _repository.getUserInterests();
        return interests;
    } 
}
