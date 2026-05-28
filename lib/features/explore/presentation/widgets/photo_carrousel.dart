import 'package:experience_app/features/explore/presentation/state/photo_carrousel_notifier.dart';
import 'package:experience_app/features/explore/presentation/state/photo_carrousel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoCarrousel extends ConsumerWidget {
  const PhotoCarrousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(photoCarrouselNotifierProvider);
    final preferredItems = state is PhotoCarrouselLoadedState ? state.preferredItems : [];
    final itemCount = preferredItems.isNotEmpty ? preferredItems.length : 0;
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: itemCount,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) {
              ref.read(photoCarrouselNotifierProvider.notifier).setCurrentPage(index);
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.network(
                  preferredItems[index].imageUrl,
                  fit: BoxFit.fitHeight,

                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(itemCount, (index) {
                final isActive = state is PhotoCarrouselLoadedState && index == state.currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 10 : 8,
                  height: isActive ? 10 : 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF006FFD)
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}