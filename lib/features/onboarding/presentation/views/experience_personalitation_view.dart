import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/onboarding/presentation/state/experience_personalitation_notifier.dart';
import 'package:experience_app/features/onboarding/presentation/widgets/container_interests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExperiencePersonalitationView extends StatelessWidget {
  const ExperiencePersonalitationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const ExperiencePersonalitationBody());
  }
}

class ExperiencePersonalitationBody extends ConsumerWidget {
  const ExperiencePersonalitationBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(experiencePersonalitationNotifierProvider);
    final interests = state.interests;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        context.goNamed(Routes.onboarding);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 16.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.0,
                  child: LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                const SizedBox(height: 20.0),

                const Text(
                  'Personalise your experience',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20.0),

                Expanded(
                  child: SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(), // Da un efecto suave al deslizar
                    child: ContainerInterests(
                      interests: interests ?? [],
                      onAdd: (interest) {
                        ref.read(experiencePersonalitationNotifierProvider.notifier).addSelectedInterest(interest);
                      },
                      onRemove: (interest) {
                        ref.read(experiencePersonalitationNotifierProvider.notifier).removeSelectedInterest(interest);
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16.0,
                ), // Separación controlada antes del botón fijo
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(experiencePersonalitationNotifierProvider.notifier).saveUserInterests();
                      context.goNamed(Routes.explore);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006FFD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
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
