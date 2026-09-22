import 'package:experience_app/features/checkout/data/repositories/sales_repository_impl.dart';
import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/checkout/domain/repositories/sales_repository.dart';
import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';

class CreateSaleUseCase {
  final SalesRepository _repository;

  CreateSaleUseCase({SalesRepository? repository})
    : _repository = repository ?? SalesRepositoryImpl();

  Future<void> call({
    required List<CartItemEntity> items,
    required String address,
    required PaymentMethod paymentMethod,
    required double total,
  }) async {
    await _repository.createSale(
      items: items,
      address: address,
      paymentMethod: paymentMethod,
      total: total,
    );
  }
}
