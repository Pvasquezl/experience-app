import 'package:experience_app/features/explore/domain/use_cases/get_shopping_chart.dart';
import 'package:experience_app/features/explore/presentation/state/shopping_cart_state.dart';
import 'package:riverpod/legacy.dart';

final shoppingCartNotifierProvider =
    StateNotifierProvider<ShoppingCartNotifier, ShoppingCartState>(
      (ref) => ShoppingCartNotifier(),
    );

class ShoppingCartNotifier extends StateNotifier<ShoppingCartState> {
  final GetShoppingCartItemCountUseCase _getShoppingCartItemCountUseCase;

  ShoppingCartNotifier({
    GetShoppingCartItemCountUseCase? getShoppingCartItemCountUseCase,
  }) : _getShoppingCartItemCountUseCase =
           getShoppingCartItemCountUseCase ?? GetShoppingCartItemCountUseCase(),
       super(ShoppingCartInitialState()) {
    loadShoppingCartItemCount();
  }

  Future<void> loadShoppingCartItemCount() async {
    final count = await _getShoppingCartItemCountUseCase();
    state = ShoppingCartLoadedState(cartItems: count);
  }
}
