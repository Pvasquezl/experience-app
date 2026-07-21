import 'package:experience_app/features/admin/products/data/data_sources/products_data_source.dart';
import 'package:experience_app/features/admin/products/data/models/product_model.dart';
import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';
import 'package:experience_app/features/admin/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataSource _dataSource;

  ProductsRepositoryImpl({ProductsDataSource? dataSource})
      : _dataSource = dataSource ?? ProductsDataSource();

  @override
  Future<List<ProductAdminEntity>> getProducts() async {
    final models = await _dataSource.getProducts();
    return models.map(_toEntity).toList();
  }

  @override
  Future<ProductAdminEntity> createProduct(ProductAdminEntity product) async {
    final model = await _dataSource.createProduct(_toModel(product));
    return _toEntity(model);
  }

  @override
  Future<ProductAdminEntity> updateProduct(ProductAdminEntity product) async {
    final model = await _dataSource.updateProduct(_toModel(product));
    return _toEntity(model);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _dataSource.deleteProduct(id);
  }

  ProductAdminEntity _toEntity(ProductModel model) {
    return ProductAdminEntity(
      id: model.id,
      name: model.name,
      price: model.price,
      available: model.available,
      quantity: model.quantity,
      image: model.image,
    );
  }

  ProductModel _toModel(ProductAdminEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      available: entity.available,
      quantity: entity.quantity,
      image: entity.image,
    );
  }
}
