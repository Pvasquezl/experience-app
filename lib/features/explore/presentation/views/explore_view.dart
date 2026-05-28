import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/explore/presentation/state/product_sections_notifier.dart';
import 'package:experience_app/features/explore/presentation/state/product_sections_state.dart';
import 'package:experience_app/features/explore/presentation/widgets/header_explore.dart';
import 'package:experience_app/features/explore/presentation/widgets/photo_carrousel.dart';
import 'package:experience_app/features/explore/presentation/widgets/product_carrousel.dart';
import 'package:experience_app/features/explore/presentation/widgets/see_more_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExploreBody();
  }
}

class ExploreBody extends ConsumerWidget {
  const ExploreBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productSectionsState = ref.watch(productSectionsNotifierProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        context.goNamed(Routes.experiencePersonalitation);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderExplore(),
                const PhotoCarrousel(),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (productSectionsState
                          is ProductSectionLoadedState) ...[
                        for (final section
                            in productSectionsState.productSections) ...[
                          SeeMoreSpace(
                            title: section.title,
                            route: Routes.onboarding,
                          ),
                          const SizedBox(height: 12.0),
                          ProductCarrousel(products: section.products),
                          const SizedBox(height: 12.0),
                        ],
                      ] else if (productSectionsState
                          is LoadingProductSectionState) ...[
                        const SizedBox(height: 40.0),
                        const Center(child: CircularProgressIndicator()),
                      ] else ...[
                        const Center(
                          child: Text('No se pudieron cargar las secciones'),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
