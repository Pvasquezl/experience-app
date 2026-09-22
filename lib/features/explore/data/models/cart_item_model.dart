class CartItemModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String? ?? '',
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      name: name,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
    );
  }
}
