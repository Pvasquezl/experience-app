import 'package:experience_app/features/onboarding/data/repositories/user_interests_repository_impl.dart';
import 'package:experience_app/features/onboarding/domain/entities/user_interests_entity.dart';
import 'package:experience_app/features/onboarding/domain/repositories/user_interests_repository.dart';

class SaveUserInterestsUseCase {
  final UserInterestsRepository _repository;
  SaveUserInterestsUseCase({UserInterestsRepository? repository})
    : _repository = repository ?? UserInterestsRepositoryImpl();

    Future<void> call(List<UserInterests> selectedInterests) async {
        await _repository.saveUserInterests(selectedInterests);
    }
}