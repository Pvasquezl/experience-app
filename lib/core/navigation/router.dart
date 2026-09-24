import 'package:experience_app/core/navigation/admin_app_shell.dart';
import 'package:experience_app/core/navigation/app_shell.dart';
import 'package:experience_app/features/admin/products/presentation/views/products_view.dart';
import 'package:experience_app/features/admin/sales/presentation/views/sales_view.dart';
import 'package:experience_app/features/cart/presentation/views/cart_view.dart';
import 'package:experience_app/features/checkout/presentation/views/checkout_view.dart';
import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/explore/presentation/views/explore_view.dart';
import 'package:experience_app/features/login/presentation/views/login_view.dart';
import 'package:experience_app/features/onboarding/presentation/views/experience_personalitation_view.dart';
import 'package:experience_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:experience_app/features/product/presentation/views/product_detail_view.dart';
import 'package:experience_app/features/sales/presentation/views/sale_detail_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: Routes.onboarding,
      path: '/onboarding',
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      name: Routes.login,
      path: '/login',
      builder: (context, state) => const LoginView(),
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
        print(product);
        return ProductDetailView(product: product);
      },
    ),
    GoRoute(
      name: Routes.cart,
      path: '/cart',
      builder: (context, state) => const CartView(),
    ),
    GoRoute(
      name: Routes.checkout,
      path: '/checkout',
      builder: (context, state) => const CheckoutView(),
    ),
    GoRoute(
      name: Routes.saleDetails,
      path: '/sale_details',
      builder: (context, state) {
        final extra = state.extra is Map ? state.extra as Map : const {};
        final saleId = (extra['saleId'] ?? extra['sale_id'])?.toString() ?? '';
        return SaleDetailView(saleId: saleId);
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AdminAppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.adminSales,
              path: '/admin_sales',
              builder: (context, state) => const SalesView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.adminProducts,
              path: '/admin_products',
              builder: (context, state) => const ProductsView(),
            ),
          ],
        ),
      ],
    ),
  ],
);

abstract class Routes {
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String experiencePersonalitation = 'experience_personalitation';
  static const String explore = 'explore';
  static const String categories = 'categories';
  static const String favorites = 'stores';
  static const String profile = 'profile';
  static const String productDetail = 'product_detail';
  static const String cart = 'cart';
  static const String checkout = 'checkout';
  static const String saleDetails = 'sale_details';
  static const String adminProducts = 'admin_products';
  static const String adminSales = 'admin_sales';
}
