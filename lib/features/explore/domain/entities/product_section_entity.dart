import 'package:experience_app/features/explore/data/models/product_section_model.dart';
import 'package:experience_app/features/explore/domain/entities/product_entity.dart';

class ProductSectionEntity {
  final String title;
  final List<ProductEntity> products;

  ProductSectionEntity({required this.title, required this.products});

  factory ProductSectionEntity.fromModel(ProductSectionModel model) {
    return ProductSectionEntity(
      title: model.title,
      products: model.products
          .map((productModel) => ProductEntity.fromModel(productModel))
          .toList(),
    );
  }
}
