import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_notifier.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPhotoCarrousel extends ConsumerWidget {
  final ProductEntity product;
  const ProductPhotoCarrousel({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailNotifierProvider(product));
    final preferredItems = state is ProductDetailLoaded
        ? state.productDetail?.image ?? []
        : [];
    final itemCount = preferredItems.isNotEmpty ? preferredItems.length : 0;
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: itemCount,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) {
              ref
                  .read(productDetailNotifierProvider(product).notifier)
                  .setCurrentPage(index);
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
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
                final isActive =
                    state is ProductDetailLoaded && index == state.currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 10 : 8,
                  height: isActive ? 10 : 8,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF006FFD) : Colors.grey,
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
