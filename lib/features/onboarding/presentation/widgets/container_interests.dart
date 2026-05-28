import 'package:experience_app/features/onboarding/presentation/state/experience_personalitation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContainerInterests extends StatelessWidget {
  const ContainerInterests({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContainerInterests();
  }
}

class _ContainerInterests extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(experiencePersonalitationNotifierProvider);
    final interests = state.interests;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: interests.asMap().entries.map((entry) {
        String title = entry.value.name;
        final selectedInterests = state.selectedInterests;
        bool isSelected = selectedInterests.any((i) => i.id == entry.value.id);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                if (isSelected) {
                  ref
                      .read(experiencePersonalitationNotifierProvider.notifier)
                      .removeSelectedInterest(entry.value);
                } else {
                  ref
                      .read(experiencePersonalitationNotifierProvider.notifier)
                      .addSelectedInterest(entry.value);
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected
                    ? const Color(0xFFEDF2FF)
                    : Colors.white,
                side: BorderSide(
                  color: isSelected
                      ? Colors.transparent
                      : const Color(0xFFE2E8F0),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF1E293B),
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check, color: Color(0xFF2563EB), size: 20),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
