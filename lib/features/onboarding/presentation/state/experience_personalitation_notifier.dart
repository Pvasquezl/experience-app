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
      state = ExperiencePersonalitationLoadedState(
        interests: interests,
      );
    } catch (e) {
      print(  "Error loading interests: $e");
    }
  }

  Future<void> saveUserInterests() async {
    final interests = state.selectedInterests;
    try {
      await _saveUserInterestsUseCase(interests);
    } catch (e) {
      // Manejo de errores
      print("Error saving interests: $e");
    }
  }

  void addSelectedInterest(UserInterests interest) {
    final alreadySelected = state.selectedInterests.any((i) => i.id == interest.id);
    final updatedInterests = [...state.selectedInterests, interest];
    if (!alreadySelected) {
      state = UpdateSelectedInterestsState(
        interests: state.interests,
        selectedInterests: updatedInterests,
      );
      print("interests data in state: ${state.interests.map((e) => e.name).toList()}");

    }
  }

  void removeSelectedInterest(UserInterests interest) {
    final updatedInterests = state.selectedInterests
        .where((i) => i.id != interest.id)
        .toList();
    if (state.selectedInterests.any((i) => i.id == interest.id)) {
      state = UpdateSelectedInterestsState(
        interests: state.interests,
        selectedInterests: updatedInterests,
      );
    }
  }
}
