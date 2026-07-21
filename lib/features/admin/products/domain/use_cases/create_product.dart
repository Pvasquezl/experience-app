import 'package:experience_app/features/admin/products/data/repositories/products_repository.dart';
import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';
import 'package:experience_app/features/admin/products/domain/repositories/products_repository.dart';

class CreateProductUseCase {
  final ProductsRepository _repository;

  CreateProductUseCase({ProductsRepository? repository})
      : _repository = repository ?? ProductsRepositoryImpl();

  Future<ProductAdminEntity> call(ProductAdminEntity product) async {
    return _repository.createProduct(product);
  }
}
