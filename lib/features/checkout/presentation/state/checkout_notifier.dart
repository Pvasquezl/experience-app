import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/checkout/presentation/state/checkout_state.dart';
import 'package:experience_app/features/explore/domain/use_cases/clear_cart.dart';
import 'package:riverpod/legacy.dart';

final checkoutNotifierProvider =
    StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
      (ref) => CheckoutNotifier(),
    );

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final ClearCartUseCase _clearCartUseCase;

  CheckoutNotifier({ClearCartUseCase? clearCartUseCase})
    : _clearCartUseCase = clearCartUseCase ?? ClearCartUseCase(),
      super(CheckoutState());

  void setAddress(String address) {
    state = state.copyWith(address: address);
  }

  void setPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method);
  }

  Future<void> confirmOrder() async {
    if (!state.canSubmit) return;
    state = state.copyWith(isSubmitting: true);
    await _clearCartUseCase();
    state = state.copyWith(isSubmitting: false, isConfirmed: true);
  }
}
