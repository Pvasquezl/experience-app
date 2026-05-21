import 'package:flutter/material.dart';
class ShoppingBagBadge extends StatelessWidget {
  final int count;

  const ShoppingBagBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          size: 32,
          color: Colors.black87,
        ),

        if (count > 0)
          Positioned(
            right: -4,
            top: 15,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF006FFD),
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  '$count',
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