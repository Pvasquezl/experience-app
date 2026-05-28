import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({super.key, required this.product, required this.onTap});

  final ProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      height: 190.0,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, color: Colors.grey, size: 40);
              },
            ),
          ),
          const SizedBox(height: 18.0),
          SizedBox(
            width: 200.0,
            child: Text(
              product.name,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              'Q ${product.price.toStringAsFixed(2)}',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
