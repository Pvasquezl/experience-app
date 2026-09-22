import 'package:experience_app/features/checkout/data/data_sources/sales_data_source.dart';
import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/checkout/domain/repositories/sales_repository.dart';
import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';

class SalesRepositoryImpl implements SalesRepository {
  final SalesDataSource _dataSource;

  SalesRepositoryImpl({SalesDataSource? dataSource})
    : _dataSource = dataSource ?? SalesDataSource();

  @override
  Future<void> createSale({
    required List<CartItemEntity> items,
    required String address,
    required PaymentMethod paymentMethod,
    required double total,
  }) async {
    await _dataSource.createSale(
      items: items,
      address: address,
      paymentMethod: paymentMethod,
      total: total,
    );
  }
}
