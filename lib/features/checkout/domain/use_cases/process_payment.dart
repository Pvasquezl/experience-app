import 'package:experience_app/features/checkout/data/repositories/payment_repository_impl.dart';
import 'package:experience_app/features/checkout/domain/repositories/payment_repository.dart';

class ProcessPaymentUseCase {
  ProcessPaymentUseCase({PaymentRepository? repository})
    : _repository = repository ?? PaymentRepositoryImpl();

  final PaymentRepository _repository;

  Future<Map<String, dynamic>> call({
    required double amount,
    required String cardNumber,
  }) async {
    return _repository.processPayment(amount: amount, cardNumber: cardNumber);
  }
}
