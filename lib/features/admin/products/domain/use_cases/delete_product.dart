import 'package:experience_app/features/admin/products/data/repositories/products_repository.dart';
import 'package:experience_app/features/admin/products/domain/repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository _repository;

  DeleteProductUseCase({ProductsRepository? repository})
      : _repository = repository ?? ProductsRepositoryImpl();

  Future<void> call(String id) async {
    return _repository.deleteProduct(id);
  }
}
