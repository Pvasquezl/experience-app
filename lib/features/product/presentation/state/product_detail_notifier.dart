import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_state.dart';
import 'package:riverpod/legacy.dart';

final productDetailNotifierProvider =
    StateNotifierProvider.family<
      ProductDetailNotifier,
      ProductDetailState,
      ProductEntity
    >((ref, product) => ProductDetailNotifier(product));

class ProductDetailNotifier extends StateNotifier<ProductDetailState> {
  final ProductEntity product;
  ProductDetailNotifier(this.product) : super(ProductDetailInitial(product));
}
