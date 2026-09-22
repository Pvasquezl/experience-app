import 'package:experience_app/features/explore/domain/entities/product_entity.dart';

class ProductDetailEntity {
  final String id;
  final String name;
  final List<String> image;
  final double price;
  final bool available;
  final int quantity;

  ProductDetailEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.quantity,
  });

  factory ProductDetailEntity.fromProduct(ProductEntity product) {
    return ProductDetailEntity(
      id: product.id,
      name: product.name,
      image: [product.image],
      price: product.price,
      available: product.available,
      quantity: product.quantity,
    );
  }
}
