import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/admin/sales/domain/entities/sale_entity.dart';
import 'package:experience_app/features/admin/sales/domain/entities/sale_item_entity.dart';

class SaleModel {
  final String id;
  final String? userId;
  final String address;
  final String paymentMethod;
  final double total;
  final List<SaleItemEntity> items;
  final DateTime? createdAt;

  SaleModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.paymentMethod,
    required this.total,
    required this.items,
    required this.createdAt,
  });

  factory SaleModel.fromFirestore(String id, Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return SaleModel(
      id: id,
      userId: json['userId'] as String?,
      address: json['address'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      items: rawItems
          .map(
            (item) => SaleItemEntity(
              productId: item['productId'] as String? ?? '',
              name: item['name'] as String? ?? '',
              image: item['image'] as String? ?? '',
              price: (item['price'] as num?)?.toDouble() ?? 0.0,
              quantity: (item['quantity'] as num?)?.toInt() ?? 0,
              subtotal: (item['subtotal'] as num?)?.toDouble() ?? 0.0,
            ),
          )
          .toList(),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  SaleEntity toEntity() {
    return SaleEntity(
      id: id,
      userId: userId,
      address: address,
      paymentMethod: paymentMethod,
      total: total,
      items: items,
      createdAt: createdAt,
    );
  }
}
