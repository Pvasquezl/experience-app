import 'package:experience_app/features/explore/domain/entities/product_entity.dart';

abstract class ProductDetailState {
  final ProductEntity product;
  ProductDetailState(this.product);
}

class ProductDetailInitial extends ProductDetailState {
  ProductDetailInitial(ProductEntity product) : super(product);
}
