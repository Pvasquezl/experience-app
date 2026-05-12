import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/onboarding/presentation/state/onboarding_notifier.dart';
import 'package:experience_app/features/onboarding/presentation/widgets/container_carrousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyWidget());
  }
}

class BodyWidget extends ConsumerWidget {
  final PageController _controller = PageController();

  BodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingRiverpodProvider);
    final pages = state.pages;
    final currentPage = state.currentPage;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // IMAGEN FIJA
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/onboarding.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // CONTENIDO
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ContainerCarrousel(
                        pages: pages,
                        controller: _controller,
                        onPageChanged: (index) {
                          ref
                              .read(onboardingRiverpodProvider.notifier)
                              .setPage(index);
                        },
                      ),
                    ),
                    // boton azul
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentPage < pages.length - 1) {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else if (currentPage == pages.length - 1) {
                            context.goNamed(Routes.experiencePersonalitation);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006FFD),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          currentPage == 0 ? "Start" : "Next",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
