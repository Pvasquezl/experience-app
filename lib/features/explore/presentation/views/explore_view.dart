import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/explore/presentation/widgets/header_explore.dart';
import 'package:experience_app/features/explore/presentation/widgets/photo_carrousel.dart';
import 'package:experience_app/features/explore/presentation/widgets/product_carrousel.dart';
import 'package:experience_app/features/explore/presentation/widgets/see_more_space.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExploreBody();
  }
}

class ExploreBody extends StatelessWidget {
  const ExploreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        context.goNamed(Routes.experiencePersonalitation);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              HeaderExplore(),
              PhotoCarrousel(),
              SizedBox(height: 12.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ), // Ajusta los lados
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeeMoreSpace(
                      title: "Perfect for you",
                      route: Routes.onboarding,
                    ),
                    SizedBox(height: 12.0),
                    ProductCarrousel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
