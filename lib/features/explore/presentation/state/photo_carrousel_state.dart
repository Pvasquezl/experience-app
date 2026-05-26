import 'package:experience_app/features/explore/domain/entities/preferred_products_entity.dart';

abstract class PhotoCarrouselState {
  late final List<PreferredProductsEntity> preferredItems;
  late final int currentPage;
  PhotoCarrouselState({required this.preferredItems, this.currentPage = 0});
}

final class PhotoCarrouselInitialState extends PhotoCarrouselState {
  PhotoCarrouselInitialState() : super(preferredItems: []);
}

final class PhotoCarrouselLoadedState extends PhotoCarrouselState {
  PhotoCarrouselLoadedState({required super.preferredItems, super.currentPage});
}