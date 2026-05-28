import 'package:experience_app/features/explore/domain/entities/product_section_entity.dart';

abstract class ProductSectionsRepository {
  Future<List<ProductSectionEntity>> getProductSections();
}
