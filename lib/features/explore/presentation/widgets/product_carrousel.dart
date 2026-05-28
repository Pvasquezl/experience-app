import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:experience_app/features/explore/presentation/widgets/product_box.dart';

class ProductCarrousel extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductCarrousel({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ProductBox(
              product: product,
              onTap: () {
                debugPrint('Tapped on ${product.id}');
              },
            ),
          );
        },
      ),
    );
  }
}
