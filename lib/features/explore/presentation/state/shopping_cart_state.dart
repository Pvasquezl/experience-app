abstract base class ShoppingCartState {
  final int cartItems;
  ShoppingCartState({this.cartItems = 0});
}

final class ShoppingCartInitialState extends ShoppingCartState {
  ShoppingCartInitialState() : super(cartItems: 0);
}

final class ShoppingCartLoadedState extends ShoppingCartState {
  ShoppingCartLoadedState({required super.cartItems});
}
