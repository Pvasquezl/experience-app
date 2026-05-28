import 'package:experience_app/features/explore/domain/entities/product_section_entity.dart';

abstract class ProductSectionState {
  late final List<ProductSectionEntity> productSections;
  ProductSectionState({required this.productSections});
}

class ProductSectionInitialState extends ProductSectionState {
  ProductSectionInitialState() : super(productSections: []);
}

class ProductSectionLoadedState extends ProductSectionState {
  ProductSectionLoadedState({required super.productSections});
}

class LoadingProductSectionState extends ProductSectionState {
  LoadingProductSectionState() : super(productSections: []);
}
