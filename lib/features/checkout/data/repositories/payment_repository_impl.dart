import 'package:experience_app/features/checkout/data/data_sources/payment_data_source.dart';
import 'package:experience_app/features/checkout/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({PaymentDataSource? dataSource})
    : _dataSource = dataSource ?? PaymentDataSource();

  final PaymentDataSource _dataSource;

  @override
  Future<Map<String, dynamic>> processPayment({
    required double amount,
    required String cardNumber,
  }) {
    return _dataSource.processPayment(amount: amount, cardNumber: cardNumber);
  }
}
