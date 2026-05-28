import 'package:experience_app/features/explore/data/data_sources/product_sections_data_source.dart';
import 'package:experience_app/features/explore/domain/entities/product_section_entity.dart';
import 'package:experience_app/features/explore/domain/repositories/product_sections_repository_impl.dart';

class ProductSectionsRepositoryImpl extends ProductSectionsRepository {
  final ProductSectionsDataSource _dataSource;

  ProductSectionsRepositoryImpl({ProductSectionsDataSource? dataSource})
    : _dataSource = dataSource ?? ProductSectionsDataSource();

  @override
  Future<List<ProductSectionEntity>> getProductSections() async {
    final response = await _dataSource.getPreferredProducts();
    return response
        .map((model) => ProductSectionEntity.fromModel(model))
        .toList();
  }
}
