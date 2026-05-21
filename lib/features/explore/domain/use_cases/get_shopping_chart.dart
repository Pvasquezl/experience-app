import 'package:experience_app/features/explore/data/repositories/shopping_cart_repository_impl.dart';
import 'package:experience_app/features/explore/domain/repositories/shopping_cart_repository.dart';

class GetShoppingCartItemCountUseCase {
  final ShoppingCartRepository _repository;
  GetShoppingCartItemCountUseCase({ShoppingCartRepository? repository})
    : _repository = repository ?? ShoppingCartRepositoryImpl();

  Future<int> call() async {
    return await _repository.getShoppingCartItemCount();
  }
}
