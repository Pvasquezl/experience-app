import 'package:experience_app/features/explore/domain/use_cases/get_product_sections.dart';
import 'package:experience_app/features/explore/presentation/state/product_sections_state.dart';
import 'package:riverpod/legacy.dart';

final productSectionsNotifierProvider =
    StateNotifierProvider<ProductSectionsNotifier, ProductSectionState>(
      (ref) => ProductSectionsNotifier(),
    );

class ProductSectionsNotifier extends StateNotifier<ProductSectionState> {
  final GetProductSectionsUseCase _getProductSectionsUseCase;
  ProductSectionsNotifier({
    GetProductSectionsUseCase? getProductSectionsUseCase,
  }) : _getProductSectionsUseCase =
           getProductSectionsUseCase ?? GetProductSectionsUseCase(),
       super(ProductSectionInitialState()) {
    loadProductSections();
  }

  Future<void> loadProductSections() async {
    state = LoadingProductSectionState();
    try {
      final sections = await _getProductSectionsUseCase();
      state = ProductSectionLoadedState(productSections: sections);
    } catch (e) {
      print('Error loading product sections: $e');
    }
  }
}
