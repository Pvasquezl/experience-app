import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/checkout/domain/use_cases/create_sale.dart';
import 'package:experience_app/features/checkout/domain/use_cases/process_payment.dart';
import 'package:experience_app/features/checkout/presentation/state/checkout_state.dart';
import 'package:experience_app/features/explore/domain/use_cases/clear_cart.dart';
import 'package:experience_app/features/explore/domain/use_cases/get_cart_items.dart';
import 'package:riverpod/legacy.dart';

final checkoutNotifierProvider =
    StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
      (ref) => CheckoutNotifier(),
    );

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final GetCartItemsUseCase _getCartItemsUseCase;
  final CreateSaleUseCase _createSaleUseCase;
  final ProcessPaymentUseCase _processPaymentUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CheckoutNotifier({
    GetCartItemsUseCase? getCartItemsUseCase,
    CreateSaleUseCase? createSaleUseCase,
    ProcessPaymentUseCase? processPaymentUseCase,
    ClearCartUseCase? clearCartUseCase,
  }) : _getCartItemsUseCase = getCartItemsUseCase ?? GetCartItemsUseCase(),
       _createSaleUseCase = createSaleUseCase ?? CreateSaleUseCase(),
       _processPaymentUseCase =
           processPaymentUseCase ?? ProcessPaymentUseCase(),
       _clearCartUseCase = clearCartUseCase ?? ClearCartUseCase(),
       super(CheckoutState());

  void setAddress(String address) {
    state = state.copyWith(address: address);
  }

  void setPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method, paymentError: null);
  }

  void setCardNumber(String cardNumber) {
    final cleanNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    state = state.copyWith(cardNumber: cleanNumber, paymentError: null);
  }

  Future<void> confirmOrder() async {
    if (!state.canSubmit) return;
    state = state.copyWith(isSubmitting: true, paymentError: null);

    try {
      final items = await _getCartItemsUseCase();
      final total = items.fold<double>(0.0, (sum, item) => sum + item.subtotal);

      if (state.paymentMethod == PaymentMethod.card) {
        final paymentResponse = await _processPaymentUseCase(
          amount: total,
          cardNumber: state.cardNumber.trim(),
        );

        final success = paymentResponse['success'] == true;
        if (!success) {
          final message =
              paymentResponse['message']?.toString() ??
              'Tu tarjeta fue rechazada.';
          state = state.copyWith(isSubmitting: false, paymentError: message);
          return;
        }
      }

      await _createSaleUseCase(
        items: items,
        address: state.address.trim(),
        paymentMethod: state.paymentMethod!,
        total: total,
      );
      await _clearCartUseCase();

      state = state.copyWith(
        isSubmitting: false,
        isConfirmed: true,
        paymentError: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        paymentError: 'No se pudo completar el pago. Inténtalo de nuevo.',
      );
    }
  }
}
