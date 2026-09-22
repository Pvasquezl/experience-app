import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';

class CheckoutState {
  final String address;
  final PaymentMethod? paymentMethod;
  final bool isSubmitting;
  final bool isConfirmed;

  CheckoutState({
    this.address = '',
    this.paymentMethod,
    this.isSubmitting = false,
    this.isConfirmed = false,
  });

  bool get canSubmit => address.trim().isNotEmpty && paymentMethod != null;

  CheckoutState copyWith({
    String? address,
    PaymentMethod? paymentMethod,
    bool? isSubmitting,
    bool? isConfirmed,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}
