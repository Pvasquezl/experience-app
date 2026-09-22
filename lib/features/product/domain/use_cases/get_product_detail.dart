import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/domain/entities/product_detail_entity.dart';

class GetProductDetailUseCase {
  Future<ProductDetailEntity> call(ProductEntity product) async {
    return ProductDetailEntity.fromProduct(product);
  }
}
