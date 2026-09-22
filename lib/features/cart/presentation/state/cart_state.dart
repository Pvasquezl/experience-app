import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';

abstract class CartState {
  final List<CartItemEntity> items;
  final bool isLoading;
  CartState({required this.items, this.isLoading = false});

  double get total => items.fold(0.0, (sum, item) => sum + item.subtotal);
}

class CartInitialState extends CartState {
  CartInitialState() : super(items: [], isLoading: true);
}

class CartLoadedState extends CartState {
  CartLoadedState({required super.items});
}
