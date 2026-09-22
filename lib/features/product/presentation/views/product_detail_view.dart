import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/explore/presentation/state/shopping_cart_notifier.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_notifier.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_state.dart';
import 'package:experience_app/features/product/presentation/widgets/product_photo_carrousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailView extends ConsumerWidget {
  const ProductDetailView({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailNotifierProvider(product));
    final detail = state is ProductDetailLoaded ? state.productDetail : null;
    final selectedQuantity = state.selectedQuantity;
    final notifier = ref.read(productDetailNotifierProvider(product).notifier);
    final inStock = detail != null && detail.available && detail.quantity > 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        context.goNamed(Routes.explore);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(product.name)),
        body: detail == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductPhotoCarrousel(product: product),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16.0),
                            Text(
                              detail.name,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Q ${detail.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006FFD),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              inStock
                                  ? '${detail.quantity} disponibles'
                                  : 'Producto agotado',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: inStock ? Colors.grey[700] : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 24.0),
                            Text(
                              'Cantidad',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: inStock && selectedQuantity > 1
                                      ? () => notifier.setSelectedQuantity(
                                          selectedQuantity - 1,
                                        )
                                      : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text(
                                  '$selectedQuantity',
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                IconButton(
                                  onPressed:
                                      inStock &&
                                          selectedQuantity < detail.quantity
                                      ? () => notifier.setSelectedQuantity(
                                          selectedQuantity + 1,
                                        )
                                      : null,
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: inStock
                                    ? () async {
                                        final added = await notifier
                                            .addToCart();
                                        if (!context.mounted) return;
                                        if (added) {
                                          await ref
                                              .read(
                                                shoppingCartNotifierProvider
                                                    .notifier,
                                              )
                                              .loadShoppingCartItemCount();
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Producto añadido al carrito',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                child: const Text('Añadir al carrito'),
                              ),
                            ),
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
