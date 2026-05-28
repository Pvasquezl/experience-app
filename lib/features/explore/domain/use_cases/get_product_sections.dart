import 'package:experience_app/features/explore/data/repositories/product_sections_repository_impl.dart';
import 'package:experience_app/features/explore/domain/entities/product_section_entity.dart';
import 'package:experience_app/features/explore/domain/repositories/product_sections_repository_impl.dart';

class GetProductSectionsUseCase {
  final ProductSectionsRepository repository;

  GetProductSectionsUseCase({ProductSectionsRepository? repository})
    : repository = repository ?? ProductSectionsRepositoryImpl();

  Future<List<ProductSectionEntity>> call() async {
    return await repository.getProductSections();
  }
}
