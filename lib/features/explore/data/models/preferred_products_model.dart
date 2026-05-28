import 'package:experience_app/features/explore/domain/entities/preferred_products_entity.dart';
class PreferredProductsModel {
  final int id;
  final String name;
  final String imageUrl;

  PreferredProductsModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory PreferredProductsModel.fromEntity(PreferredProductsEntity entity) {
    return PreferredProductsModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
    );
  }

  factory PreferredProductsModel.fromJson(Map<String, dynamic> json) {
    return PreferredProductsModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}