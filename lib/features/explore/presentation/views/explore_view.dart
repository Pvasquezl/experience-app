import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/explore/presentation/widgets/header_explore.dart';
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
              SizedBox(height: 16.0),
              HeaderExplore(),
              
            ],
          )
        ),
      ),
    );
  }
}