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

  factory ProductDetailEntity.fromFirestore(
    String id,
    Map<String, dynamic> json,
  ) {
    final rawImages = json['image'];
    final images = <String>[];

    if (rawImages is List) {
      for (final item in rawImages) {
        if (item is String && item.isNotEmpty) {
          images.add(item);
        }
      }
    } else if (rawImages is String && rawImages.isNotEmpty) {
      images.add(rawImages);
    }

    return ProductDetailEntity(
      id: id,
      name: json['name'] as String? ?? '',
      image: images.isNotEmpty ? images : const [''],
      price: (json['price'] as num?)?.toDouble() ?? 0,
      available: json['available'] as bool? ?? true,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
  }
}
