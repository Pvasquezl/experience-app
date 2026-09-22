import 'package:experience_app/features/explore/domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final bool available;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.available = true,
    this.quantity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      available: json['available'] as bool? ?? true,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
  }

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> json) {
    return ProductModel(
      id: id,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String? ?? '',
      available: json['available'] as bool? ?? true,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      image: entity.image,
      available: entity.available,
      quantity: entity.quantity,
    );
  }
}
