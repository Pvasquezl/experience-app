import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';

abstract class SalesRepository {
  Future<void> createSale({
    required List<CartItemEntity> items,
    required String address,
    required PaymentMethod paymentMethod,
    required double total,
  });
}
