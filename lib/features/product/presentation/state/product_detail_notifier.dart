import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/domain/use_cases/get_product_detail.dart';
import 'package:experience_app/features/explore/domain/use_cases/add_to_cart.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_state.dart';
import 'package:riverpod/legacy.dart';

final productDetailNotifierProvider =
    StateNotifierProvider.family<
      ProductDetailNotifier,
      ProductDetailState,
      ProductEntity
    >((ref, product) => ProductDetailNotifier(product: product));

class ProductDetailNotifier extends StateNotifier<ProductDetailState> {
  final ProductEntity product;
  final GetProductDetailUseCase _getProductDetailUseCase;
  final AddToCartUseCase _addToCartUseCase;

  ProductDetailNotifier({
    required this.product,
    GetProductDetailUseCase? getProductDetailUseCase,
    AddToCartUseCase? addToCartUseCase,
  }) : _getProductDetailUseCase =
           getProductDetailUseCase ?? GetProductDetailUseCase(),
       _addToCartUseCase = addToCartUseCase ?? AddToCartUseCase(),
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
        selectedQuantity: currentState.selectedQuantity,
      );
    }
  }

  void setSelectedQuantity(int quantity) {
    if (state is! ProductDetailLoaded) return;
    final currentState = state as ProductDetailLoaded;
    final maxQuantity = currentState.productDetail?.quantity ?? 1;
    if (quantity < 1 || quantity > maxQuantity) return;
    state = ProductDetailLoaded(
      product: currentState.product,
      productDetail: currentState.productDetail,
      currentPage: currentState.currentPage,
      selectedQuantity: quantity,
    );
  }

  Future<void> loadProductDetail() async {
    final detail = await _getProductDetailUseCase(product);
    state = ProductDetailLoaded(product: product, productDetail: detail);
  }

  Future<bool> addToCart() async {
    if (state is! ProductDetailLoaded) return false;
    final currentState = state as ProductDetailLoaded;
    final detail = currentState.productDetail;
    if (detail == null || !detail.available || detail.quantity <= 0) {
      return false;
    }

    await _addToCartUseCase(
      id: detail.id,
      name: detail.name,
      price: detail.price,
      image: detail.image.first,
      quantity: currentState.selectedQuantity,
    );
    return true;
  }
}
