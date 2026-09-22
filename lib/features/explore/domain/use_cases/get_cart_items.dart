import 'package:experience_app/features/explore/data/repositories/shopping_cart_repository_impl.dart';
import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';
import 'package:experience_app/features/explore/domain/repositories/shopping_cart_repository.dart';

class GetCartItemsUseCase {
  final ShoppingCartRepository _repository;
  GetCartItemsUseCase({ShoppingCartRepository? repository})
    : _repository = repository ?? ShoppingCartRepositoryImpl();

  Future<List<CartItemEntity>> call() async {
    return await _repository.getCartItems();
  }
}
