import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/sales/presentation/state/sale_detail_notifier.dart';
import 'package:experience_app/features/sales/presentation/state/sale_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SaleDetailView extends ConsumerWidget {
  const SaleDetailView({super.key, required this.saleId});

  final String saleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(saleDetailNotifierProvider(saleId));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        context.goNamed(Routes.explore);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            'Mi compra',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF1F2937)),
        ),
        body: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SaleDetailState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  size: 42,
                  color: Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                state.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF475569), fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    final sale = state.sale;
    if (sale == null) {
      return const Center(
        child: Text('No hay información disponible para esta compra.'),
      );
    }

    final total = sale['total'] ?? 0;
    final address = sale['address'] ?? 'Sin dirección';
    final paymentMethod = sale['paymentMethod'] ?? 'Sin método de pago';
    final orderNumber = sale['id'] ?? saleId;
    final items = sale['items'] is List
        ? sale['items'] as List
        : const <dynamic>[];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Pedido confirmado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Compra',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Id compra: $orderNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu pedido está listo y ya fue procesado correctamente.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _MiniInfo(label: 'Pago', value: paymentMethod.toString()),
                    const SizedBox(width: 10),
                    _MiniInfo(label: 'Total', value: '\$$total'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE2E8F0).withOpacity(0.8),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _SummaryRow(
                  icon: Icons.location_on_outlined,
                  label: 'Entrega',
                  value: address.toString(),
                ),
                const Divider(height: 24),
                _SummaryRow(
                  icon: Icons.credit_card_rounded,
                  label: 'Método de pago',
                  value: paymentMethod.toString(),
                ),
                const Divider(height: 24),
                _SummaryRow(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Total',
                  value: '\$$total',
                  accent: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Productos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (items.isNotEmpty)
            ...items.map((item) {
              final product = item is Map ? item : <String, dynamic>{};
              final productName = product['name'] ?? 'Producto';
              final quantity = product['quantity'] ?? 1;
              final subtotal = product['subtotal'] ?? 0;
              final imageUrl = product['image']?.toString() ?? '';

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE2E8F0).withOpacity(0.7),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: imageUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: imageUrl.isEmpty
                            ? const Color(0xFFEEF2FF)
                            : null,
                      ),
                      child: imageUrl.isEmpty
                          ? const Icon(
                              Icons.shopping_bag_outlined,
                              color: Color(0xFF4F46E5),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF1F2937),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Cantidad: $quantity',
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$$subtotal',
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            }).toList()
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'No hay productos en esta compra.',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ),
        ],
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  const _MiniInfo({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.16),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.accent = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent ? const Color(0xFFEEF2FF) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: accent ? const Color(0xFF4F46E5) : const Color(0xFF475569),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: accent
                      ? const Color(0xFF111827)
                      : const Color(0xFF1F2937),
                  fontSize: 14,
                  fontWeight: accent ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
