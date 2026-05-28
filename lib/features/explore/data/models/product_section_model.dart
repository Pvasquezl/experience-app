import 'package:experience_app/features/explore/data/models/product_model.dart';
import 'package:experience_app/features/explore/domain/entities/product_section_entity.dart';

class ProductSectionModel {
  final String title;
  final List<ProductModel> products;

  ProductSectionModel({required this.title, required this.products});

  factory ProductSectionModel.fromJson(Map<String, dynamic> json) {
    return ProductSectionModel(
      title: json['title'] as String,
      products: (json['products'] as List<dynamic>)
          .map(
            (productJson) =>
                ProductModel.fromJson(productJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  factory ProductSectionModel.fromEntity(ProductSectionEntity entity) {
    return ProductSectionModel(
      title: entity.title,
      products: entity.products
          .map((productEntity) => ProductModel.fromEntity(productEntity))
          .toList(),
    );
  }
}
