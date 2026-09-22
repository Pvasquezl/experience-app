import 'package:experience_app/features/explore/domain/use_cases/add_to_cart.dart';
import 'package:experience_app/features/explore/domain/use_cases/get_shopping_chart.dart';
import 'package:experience_app/features/explore/presentation/state/shopping_cart_state.dart';
import 'package:riverpod/legacy.dart';

final shoppingCartNotifierProvider =
    StateNotifierProvider<ShoppingCartNotifier, ShoppingCartState>(
      (ref) => ShoppingCartNotifier(),
    );

class ShoppingCartNotifier extends StateNotifier<ShoppingCartState> {
  final GetShoppingCartItemCountUseCase _getShoppingCartItemCountUseCase;
  final AddToCartUseCase _addToCartUseCase;

  ShoppingCartNotifier({
    GetShoppingCartItemCountUseCase? getShoppingCartItemCountUseCase,
    AddToCartUseCase? addToCartUseCase,
  }) : _getShoppingCartItemCountUseCase =
           getShoppingCartItemCountUseCase ?? GetShoppingCartItemCountUseCase(),
       _addToCartUseCase = addToCartUseCase ?? AddToCartUseCase(),
       super(ShoppingCartInitialState()) {
    loadShoppingCartItemCount();
  }

  Future<void> loadShoppingCartItemCount() async {
    final count = await _getShoppingCartItemCountUseCase.call();
    state = ShoppingCartLoadedState(cartItems: count);
  }

  Future<void> addToCart({
    required String id,
    required String name,
    required double price,
    required String image,
    required int quantity,
  }) async {
    await _addToCartUseCase(
      id: id,
      name: name,
      price: price,
      image: image,
      quantity: quantity,
    );
    await loadShoppingCartItemCount();
  }
}
