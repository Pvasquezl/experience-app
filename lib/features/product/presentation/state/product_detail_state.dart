import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/domain/entities/product_detail_entity.dart';

abstract class ProductDetailState {
  final ProductEntity product;
  final ProductDetailEntity? productDetail;
  late final int currentPage;
  ProductDetailState({
    required this.product,
    required this.productDetail,
    this.currentPage = 0,
  });
}

class ProductDetailInitial extends ProductDetailState {
  ProductDetailInitial(ProductEntity product)
    : super(product: product, productDetail: null);
}

class ProductDetailLoaded extends ProductDetailState {
  ProductDetailLoaded({
    required super.product,
    required super.productDetail,
    super.currentPage = 0,
  });
}
