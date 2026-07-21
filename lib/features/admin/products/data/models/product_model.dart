class ProductModel {
  final String id;
  final String name;
  final double price;
  final bool available;
  final int quantity;
  final String image;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.quantity,
    required this.image,
  });

  factory ProductModel.fromJson(String id, Map<String, dynamic> json) {
    return ProductModel(
      id: id,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      available: json['available'] as bool,
      quantity: (json['quantity'] as num).toInt(),
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'available': available,
      'quantity': quantity,
      'image': image,
    };
  }
}
