import 'package:experience_app/core/navigation/app_shell.dart';
import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/explore/presentation/views/explore_view.dart';
import 'package:experience_app/features/onboarding/presentation/views/experience_personalitation_view.dart';
import 'package:experience_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:experience_app/features/product/presentation/views/product_detail_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/product_detail',
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
    GoRoute(
      name: Routes.productDetail,
      path: '/product_detail',
      builder: (context, state) {
        final product = state.extra as ProductEntity;
        return ProductDetailView(product: product);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.explore,
              path: '/explore',
              builder: (context, state) => const ExploreView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.categories,
              path: '/categories',
              builder: (context, state) => const ExploreView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.favorites,
              path: '/stores',
              builder: (context, state) => const ExploreView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.profile,
              path: '/profile',
              builder: (context, state) => const ExploreView(),
            ),
          ],
        ),
      ],
    ),
  ],
);

abstract class Routes {
  static const String onboarding = 'onboarding';
  static const String experiencePersonalitation = 'experience_personalitation';
  static const String explore = 'explore';
  static const String categories = 'categories';
  static const String favorites = 'stores';
  static const String profile = 'profile';
  static const String productDetail = 'product_detail';
}
