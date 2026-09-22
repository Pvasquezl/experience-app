class SaleItemEntity {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final double subtotal;

  SaleItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });
}
