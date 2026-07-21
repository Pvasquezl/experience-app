import 'package:experience_app/features/admin/products/data/repositories/products_repository.dart';
import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';
import 'package:experience_app/features/admin/products/domain/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _repository;

  GetProductsUseCase({ProductsRepository? repository})
      : _repository = repository ?? ProductsRepositoryImpl();

  Future<List<ProductAdminEntity>> call() async {
    return _repository.getProducts();
  }
}
