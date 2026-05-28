import 'package:experience_app/features/explore/data/models/product_model.dart';

class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      image: model.image,
      price: model.price,
    );
  }
}
