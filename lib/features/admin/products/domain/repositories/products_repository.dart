import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductAdminEntity>> getProducts();
  Future<ProductAdminEntity> createProduct(ProductAdminEntity product);
  Future<ProductAdminEntity> updateProduct(ProductAdminEntity product);
  Future<void> deleteProduct(String id);
}
