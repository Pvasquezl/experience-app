import 'package:experience_app/features/onboarding/presentation/views/experience_personalitation_view.dart';
import 'package:experience_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      name: Routes.onboarding,
      path: '/onboarding',
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      name: Routes.experiencePersonalitation,
      path: '/experience_personalitation',
      builder: (context, state) => const ExperiencePersonalitationView(),
    ),
  ],
);

abstract class Routes {
  static const String onboarding = 'onboarding';
  static const String experiencePersonalitation = 'experience_personalitation';
}
