import 'package:experience_app/core/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: const ExploreBody(),
    );
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
      child: const Text('Explore Body'),
    );
  }
}