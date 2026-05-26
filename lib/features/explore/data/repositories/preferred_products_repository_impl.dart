import 'package:experience_app/features/explore/data/data_sources/preferred_products_data_source.dart';
import 'package:experience_app/features/explore/domain/entities/preferred_products_entity.dart';
import 'package:experience_app/features/explore/domain/repositories/preferred_products_repository.dart';

class PreferredProductsRepositoryImpl extends PreferredProductsRepository {
  final PreferredProductsDataSource _dataSource;
  PreferredProductsRepositoryImpl({PreferredProductsDataSource? dataSource})
    : _dataSource = dataSource ?? PreferredProductsDataSource();

  @override
  Future<List<PreferredProductsEntity>> getPreferredProducts() async {
    final preferredProducts = await _dataSource.getPreferredProducts();
    return preferredProducts
        .map((model) => PreferredProductsEntity.fromModel(model))
        .toList();
  }
}
