import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';

abstract class ShoppingCartRepository {
  Future<int> getShoppingCartItemCount();

  Future<List<CartItemEntity>> getCartItems();

  Future<void> addToCart({
    required String id,
    required String name,
    required double price,
    required String image,
    required int quantity,
  });

  Future<void> clearCart();
}
