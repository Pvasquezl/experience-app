import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/domain/use_cases/get_product_detail.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_state.dart';
import 'package:riverpod/legacy.dart';


final productDetailNotifierProvider = StateNotifierProviderFamily<ProductDetailNotifier, ProductDetailState, ProductEntity>(
  (ref, product) => ProductDetailNotifier(product: product),
);


class ProductDetailNotifier extends StateNotifier<ProductDetailState> {
  final ProductEntity product;
  final GetProductDetail _getProductDetailUseCase;
  
  ProductDetailNotifier({required this.product, GetProductDetail? getProductDetailUseCase})
      : _getProductDetailUseCase = getProductDetailUseCase ?? GetProductDetail(),
        super(ProductDetailInitial(product)) {
    loadProductDetail();
  }

  void setCurrentPage(int page) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      state = ProductDetailLoaded(
        product: currentState.product,
        productDetail: currentState.productDetail,
        currentPage: page,
      );
    }
  }

  Future<void> loadProductDetail() async {
    // Simulación de carga de detalles del producto
    print('Cargando detalles del producto: ${product.name}');
  }
}
