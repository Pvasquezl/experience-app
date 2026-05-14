import 'package:experience_app/features/onboarding/domain/entities/user_interests_entity.dart';
import 'package:experience_app/features/onboarding/domain/use_cases/get_user_interests_use_case.dart';
import 'package:experience_app/features/onboarding/domain/use_cases/save_user_interests_use_case.dart';
import 'package:experience_app/features/onboarding/presentation/state/experience_personalitation_state.dart';
import 'package:riverpod/legacy.dart';

final experiencePersonalitationNotifierProvider =
    StateNotifierProvider<
      ExperiencePersonalitationNotifier,
      ExperiencePersonalitationState
    >((ref) => ExperiencePersonalitationNotifier());

class ExperiencePersonalitationNotifier
    extends StateNotifier<ExperiencePersonalitationState> {
  final GetUserInterestsUseCase _getUserInterestsUseCase;
  final SaveUserInterestsUseCase _saveUserInterestsUseCase;
  final List<UserInterests> _selectedInterests = [];

  ExperiencePersonalitationNotifier({
    GetUserInterestsUseCase? getUserInterestsUseCase,
    SaveUserInterestsUseCase? saveUserInterestsUseCase,
  }) : _getUserInterestsUseCase =
           getUserInterestsUseCase ?? GetUserInterestsUseCase(),
       _saveUserInterestsUseCase =
           saveUserInterestsUseCase ?? SaveUserInterestsUseCase(),
       super(ExperiencePersonalitationInitialState()) {
    loadUserInterests();
  }

  Future<void> loadUserInterests() async {
    try {
      final interests = await _getUserInterestsUseCase();
      state = ExperiencePersonalitationLoadedState(interests: interests);
    } catch (e) {
      // Manejo de errores
    }
  }

  Future<void> saveUserInterests() async {
    final interests = _selectedInterests;
    try {
      await _saveUserInterestsUseCase(interests);
    } catch (e) {
      // Manejo de errores
    }
  }

  void addSelectedInterest(UserInterests interest) {
    if (!_selectedInterests.contains(interest)) {
      _selectedInterests.add(interest);
    }
  }

  void removeSelectedInterest(UserInterests interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    }
  }
}
