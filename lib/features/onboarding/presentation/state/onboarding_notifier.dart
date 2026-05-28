import 'package:experience_app/features/onboarding/presentation/state/onboarding_state.dart';
import 'package:riverpod/legacy.dart';

final onboardingRiverpodProvider =
    StateNotifierProvider<OnboardingProvider, OnboardingState>(
      (ref) => OnboardingProvider(),
    );

class OnboardingProvider extends StateNotifier<OnboardingState> {
  OnboardingProvider()
    : super(
        OnboardingState(
          currentPage: 0,
          pages: [
            {
              "title": "Create a prototype in just a few minutes",
              "desc":
                  "Enjoy these pre-made components and worry only about creating the best product ever",
            },
            {
              "title": "Design beautiful apps faster and better",
              "desc":
                  "Build interfaces quickly with reusable widgets and components.",
            },
            {
              "title": "Launch your next project here with us",
              "desc":
                  "Save time and focus on creating amazing user experiences.",
            },
          ],
        ),
      );

  void setPage(int index) {
    state = state.updateSelection(currentPage: index);
    if (index == state.pages.length - 1) {
      print("Onboarding completed");
    }
    print("Current page: ${state.currentPage}");
  }
}
