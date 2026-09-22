import 'package:experience_app/features/explore/data/data_sources/local_shopping_cart.dart';
import 'package:experience_app/features/explore/data/models/cart_item_model.dart';
import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';
import 'package:experience_app/features/explore/domain/repositories/shopping_cart_repository.dart';

class ShoppingCartRepositoryImpl extends ShoppingCartRepository {
  final LocalShoppingCartDataSource _dataSource;

  ShoppingCartRepositoryImpl({LocalShoppingCartDataSource? dataSource})
    : _dataSource = dataSource ?? LocalShoppingCartDataSource();
  @override
  Future<int> getShoppingCartItemCount() async {
    return await _dataSource.getShoppingCartItemCount();
  }

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final items = await _dataSource.getCartItems();
    return items
        .map(
          (item) => CartItemEntity(
            id: item.id,
            name: item.name,
            price: item.price,
            image: item.image,
            quantity: item.quantity,
          ),
        )
        .toList();
  }

  @override
  Future<void> addToCart({
    required String id,
    required String name,
    required double price,
    required String image,
    required int quantity,
  }) async {
    await _dataSource.addItem(
      CartItemModel(
        id: id,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
      ),
    );
  }

  @override
  Future<void> clearCart() async {
    await _dataSource.clearCart();
  }
}
