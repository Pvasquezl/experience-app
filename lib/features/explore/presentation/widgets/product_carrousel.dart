import 'package:flutter/material.dart';
import 'package:experience_app/features/explore/presentation/widgets/product_box.dart';

class ProductCarrousel extends StatefulWidget {
  const ProductCarrousel({super.key});

  @override
  State<ProductCarrousel> createState() => _ProductCarrouselState();
}

class _ProductCarrouselState extends State<ProductCarrousel> {
  final List<Map<String, Object>> products = [
    {'name': 'Product 1', 'price': 29.99},
    {'name': 'Product 2', 'price': 49.99},
    {'name': 'Product 3', 'price': 19.99},
    {'name': 'Product 4', 'price': 39.99},
    {'name': 'Product 5', 'price': 24.99},
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
  height: 210,
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: products.length,
    separatorBuilder: (_, __) => const SizedBox(width: 12),
    itemBuilder: (context, index) {
      final product = products[index];
      return ProductBox(
        productName: product['name'] as String,
        productImage:
            'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto.jpg',
        price: product['price'] as double,
        onTap: () {
          debugPrint('Tapped on ${product['name']}');
        },
      );
    },
  ),
);
  }
}