import 'package:experience_app/features/explore/domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      image: entity.image,
    );
  }
}
