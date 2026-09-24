import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';

class CheckoutState {
  final String address;
  final PaymentMethod? paymentMethod;
  final String cardNumber;
  final String? paymentError;
  final bool isSubmitting;
  final bool isConfirmed;

  CheckoutState({
    this.address = '',
    this.paymentMethod,
    this.cardNumber = '',
    this.paymentError,
    this.isSubmitting = false,
    this.isConfirmed = false,
  });

  bool get canSubmit {
    if (address.trim().isEmpty || paymentMethod == null) return false;
    if (paymentMethod == PaymentMethod.card) {
      return cardNumber.replaceAll(RegExp(r'\s+'), '').length >= 12;
    }
    return true;
  }

  CheckoutState copyWith({
    String? address,
    PaymentMethod? paymentMethod,
    String? cardNumber,
    String? paymentError,
    bool? isSubmitting,
    bool? isConfirmed,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardNumber: cardNumber ?? this.cardNumber,
      paymentError: paymentError ?? this.paymentError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}
