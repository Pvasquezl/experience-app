class CartItemEntity {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  CartItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  double get subtotal => price * quantity;
}
