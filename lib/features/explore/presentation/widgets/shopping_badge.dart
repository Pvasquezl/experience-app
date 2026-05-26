import 'package:experience_app/features/explore/presentation/state/shopping_cart_notifier.dart';
import 'package:experience_app/features/explore/presentation/state/shopping_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingBagBadge extends ConsumerWidget {
  const ShoppingBagBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shoppingCartNotifierProvider);
    final cartItems = state is ShoppingCartLoadedState ? state.cartItems : 0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          size: 32,
          color: Colors.black87,
        ),

        if (state is ShoppingCartLoadedState && cartItems > 0)
          Positioned(
            right: -4,
            top: 15,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF006FFD),
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text(
                  '$cartItems',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
