class ProductAdminEntity {
  final String id;
  final String name;
  final double price;
  final bool available;
  final int quantity;
  final String image;
  final bool favorite;

  ProductAdminEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.quantity,
    required this.image,
    this.favorite = false,
  });

  ProductAdminEntity copyWith({
    String? id,
    String? name,
    double? price,
    bool? available,
    int? quantity,
    String? image,
    bool? favorite,
  }) {
    return ProductAdminEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      available: available ?? this.available,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      favorite: favorite ?? this.favorite,
    );
  }
}
