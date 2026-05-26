import 'package:experience_app/features/explore/domain/entities/preferred_products_entity.dart';

abstract class PreferredProductsRepository {
  Future<List<PreferredProductsEntity>> getPreferredProducts();
}