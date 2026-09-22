import 'package:experience_app/features/admin/sales/domain/entities/sale_item_entity.dart';

class SaleEntity {
  final String id;
  final String? userId;
  final String address;
  final String paymentMethod;
  final double total;
  final List<SaleItemEntity> items;
  final DateTime? createdAt;

  SaleEntity({
    required this.id,
    required this.userId,
    required this.address,
    required this.paymentMethod,
    required this.total,
    required this.items,
    required this.createdAt,
  });
}
