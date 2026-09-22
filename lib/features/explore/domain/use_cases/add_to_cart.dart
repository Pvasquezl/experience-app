import 'package:experience_app/features/explore/data/repositories/shopping_cart_repository_impl.dart';
import 'package:experience_app/features/explore/domain/repositories/shopping_cart_repository.dart';

class AddToCartUseCase {
  final ShoppingCartRepository _repository;
  AddToCartUseCase({ShoppingCartRepository? repository})
    : _repository = repository ?? ShoppingCartRepositoryImpl();

  Future<void> call({
    required String id,
    required String name,
    required double price,
    required String image,
    required int quantity,
  }) async {
    await _repository.addToCart(
      id: id,
      name: name,
      price: price,
      image: image,
      quantity: quantity,
    );
  }
}
