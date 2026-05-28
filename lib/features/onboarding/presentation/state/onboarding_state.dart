class OnboardingState {
  final List<Map<String, String>> pages;
  final int currentPage;

  const OnboardingState({required this.pages, required this.currentPage});

  OnboardingState updateSelection({
    List<Map<String, String>>? pages,
    int? currentPage,
  }) {
    return OnboardingState(
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
