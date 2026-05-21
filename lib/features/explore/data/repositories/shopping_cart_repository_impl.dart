import 'package:experience_app/features/explore/data/data_sources/local_shopping_cart.dart';
import 'package:experience_app/features/explore/domain/repositories/shopping_cart_repository.dart';

class ShoppingCartRepositoryImpl extends ShoppingCartRepository {
  final LocalShoppingCartDataSource _dataSource;

  ShoppingCartRepositoryImpl({LocalShoppingCartDataSource? dataSource})
    : _dataSource = dataSource ?? LocalShoppingCartDataSource();
  @override
  Future<int> getShoppingCartItemCount() async {
    return await _dataSource.getShoppingCartItemCount();
  }
}
