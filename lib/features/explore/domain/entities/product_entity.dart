import 'package:experience_app/features/explore/data/models/product_model.dart';

class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;
  final bool available;
  final int quantity;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.available = true,
    this.quantity = 0,
  });

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      image: model.image,
      price: model.price,
      available: model.available,
      quantity: model.quantity,
    );
  }
}
