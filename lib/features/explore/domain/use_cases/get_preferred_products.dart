import 'package:experience_app/features/explore/data/repositories/preferred_products_repository_Impl.dart';
import 'package:experience_app/features/explore/domain/entities/preferred_products_entity.dart';
import 'package:experience_app/features/explore/domain/repositories/preferred_products_repository.dart';

class GetPreferredProductsUseCase {
  final PreferredProductsRepository _preferredProductsEntity;

  GetPreferredProductsUseCase({
    PreferredProductsRepository? preferredProductsEntity,
  }) : _preferredProductsEntity =
           preferredProductsEntity ?? PreferredProductsRepositoryImpl();

  Future<List<PreferredProductsEntity>> call() async {
    return await _preferredProductsEntity.getPreferredProducts();
  }
}
