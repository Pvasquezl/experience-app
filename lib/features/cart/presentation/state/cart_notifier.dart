import 'package:experience_app/features/explore/domain/use_cases/get_cart_items.dart';
import 'package:experience_app/features/cart/presentation/state/cart_state.dart';
import 'package:riverpod/legacy.dart';

final cartNotifierProvider =
    StateNotifierProvider.autoDispose<CartNotifier, CartState>(
      (ref) => CartNotifier(),
    );

class CartNotifier extends StateNotifier<CartState> {
  final GetCartItemsUseCase _getCartItemsUseCase;

  CartNotifier({GetCartItemsUseCase? getCartItemsUseCase})
    : _getCartItemsUseCase = getCartItemsUseCase ?? GetCartItemsUseCase(),
      super(CartInitialState()) {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final items = await _getCartItemsUseCase();
    state = CartLoadedState(items: items);
  }
}
