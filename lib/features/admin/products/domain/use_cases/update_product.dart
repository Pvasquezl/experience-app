import 'package:experience_app/features/admin/products/data/repositories/products_repository.dart';
import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';
import 'package:experience_app/features/admin/products/domain/repositories/products_repository.dart';

class UpdateProductUseCase {
  final ProductsRepository _repository;

  UpdateProductUseCase({ProductsRepository? repository})
      : _repository = repository ?? ProductsRepositoryImpl();

  Future<ProductAdminEntity> call(ProductAdminEntity product) async {
    return _repository.updateProduct(product);
  }
}
