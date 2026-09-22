import 'package:experience_app/features/explore/data/repositories/shopping_cart_repository_impl.dart';
import 'package:experience_app/features/explore/domain/repositories/shopping_cart_repository.dart';

class ClearCartUseCase {
  final ShoppingCartRepository _repository;
  ClearCartUseCase({ShoppingCartRepository? repository})
    : _repository = repository ?? ShoppingCartRepositoryImpl();

  Future<void> call() async {
    await _repository.clearCart();
  }
}
