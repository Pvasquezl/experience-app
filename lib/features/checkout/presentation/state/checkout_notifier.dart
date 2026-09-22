import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/checkout/domain/use_cases/create_sale.dart';
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
  final ClearCartUseCase _clearCartUseCase;

  CheckoutNotifier({
    GetCartItemsUseCase? getCartItemsUseCase,
    CreateSaleUseCase? createSaleUseCase,
    ClearCartUseCase? clearCartUseCase,
  }) : _getCartItemsUseCase = getCartItemsUseCase ?? GetCartItemsUseCase(),
       _createSaleUseCase = createSaleUseCase ?? CreateSaleUseCase(),
       _clearCartUseCase = clearCartUseCase ?? ClearCartUseCase(),
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

    final items = await _getCartItemsUseCase();
    final total = items.fold<double>(0.0, (sum, item) => sum + item.subtotal);

    await _createSaleUseCase(
      items: items,
      address: state.address.trim(),
      paymentMethod: state.paymentMethod!,
      total: total,
    );
    await _clearCartUseCase();

    state = state.copyWith(isSubmitting: false, isConfirmed: true);
  }
}
