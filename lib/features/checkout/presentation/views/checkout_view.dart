import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/checkout/presentation/state/checkout_notifier.dart';
import 'package:experience_app/features/explore/presentation/state/shopping_cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CheckoutView extends ConsumerWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutNotifierProvider);
    final notifier = ref.read(checkoutNotifierProvider.notifier);

    ref.listen(checkoutNotifierProvider, (previous, next) async {
      if (next.isConfirmed && previous?.isConfirmed != true) {
        await ref
            .read(shoppingCartNotifierProvider.notifier)
            .loadShoppingCartItemCount();
        if (!context.mounted) return;
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pedido confirmado'),
            content: const Text('Tu pedido se ha registrado correctamente.'),
            actions: [
              FilledButton(
                onPressed: () => context.goNamed(Routes.explore),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dirección de entrega',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              initialValue: state.address,
              onChanged: notifier.setAddress,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Calle, número, zona, ciudad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Método de pago',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            RadioListTile<PaymentMethod>(
              title: const Text('Efectivo'),
              value: PaymentMethod.cash,
              groupValue: state.paymentMethod,
              onChanged: (value) => notifier.setPaymentMethod(value!),
              contentPadding: EdgeInsets.zero,
            ),
            RadioListTile<PaymentMethod>(
              title: const Text('Tarjeta'),
              value: PaymentMethod.card,
              groupValue: state.paymentMethod,
              onChanged: (value) => notifier.setPaymentMethod(value!),
              contentPadding: EdgeInsets.zero,
            ),
            if (state.paymentMethod == PaymentMethod.card) ...[
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.cardNumber,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final formatted = value.replaceAll(RegExp(r'\D'), '');
                  final spaced = formatted
                      .replaceAllMapped(
                        RegExp(r'.{1,4}'),
                        (match) => '${match.group(0)} ',
                      )
                      .trim();
                  notifier.setCardNumber(spaced);
                },
                maxLength: 19,
                decoration: const InputDecoration(
                  hintText: '4242 4242 4242 4242',
                  labelText: 'Número de tarjeta',
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tarjetas de prueba: 4242 4242 4242 4242, 5555 5555 5555 4444, 4111 1111 1111 1111',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
            if (state.paymentError != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  state.paymentError!,
                  style: const TextStyle(color: Color(0xFFB91C1C)),
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: state.canSubmit && !state.isSubmitting
                    ? notifier.confirmOrder
                    : null,
                child: state.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Confirmar pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
