abstract class PaymentRepository {
  Future<Map<String, dynamic>> processPayment({
    required double amount,
    required String cardNumber,
  });
}
