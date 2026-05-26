import 'package:experience_app/features/explore/data/models/preferred_products_model.dart';

class PreferredProductsEntity {
  final int id;
  final String name;
  final String imageUrl;

  PreferredProductsEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory PreferredProductsEntity.fromModel(PreferredProductsModel model) {
    return PreferredProductsEntity(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
    );
  }
}