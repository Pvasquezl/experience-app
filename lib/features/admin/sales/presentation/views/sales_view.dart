import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/admin/sales/domain/entities/sale_entity.dart';
import 'package:experience_app/features/admin/sales/presentation/state/sales_provider.dart';
import 'package:experience_app/features/login/domain/use_cases/logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SalesView extends ConsumerWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesAsync = ref.watch(salesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await LogoutUseCase().call();
              if (!context.mounted) return;
              context.goNamed(Routes.login);
            },
          ),
        ],
      ),
      body: salesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error al cargar ventas: $error')),
        data: (sales) {
          if (sales.isEmpty) {
            return const Center(child: Text('Aún no hay ventas'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: sales.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) =>
                _SaleNotificationCard(sale: sales[index], isNew: index == 0),
          );
        },
      ),
    );
  }
}

class _SaleNotificationCard extends StatelessWidget {
  const _SaleNotificationCard({required this.sale, required this.isNew});

  final SaleEntity sale;
  final bool isNew;

  String get _paymentLabel =>
      sale.paymentMethod == 'cash' ? 'Efectivo' : 'Tarjeta';

  String get _timeLabel {
    final createdAt = sale.createdAt;
    if (createdAt == null) return '';
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) return 'Justo ahora';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours} h';
    return 'Hace ${diff.inDays} d';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isNew ? const Color(0xFFEAF2FF) : const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(16.0),
        border: isNew
            ? Border.all(color: const Color(0xFF006FFD), width: 1.0)
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color(0xFF006FFD),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Nueva venta · Q ${sale.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Text(
                      _timeLabel,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${sale.items.length} producto(s) · $_paymentLabel',
                  style: TextStyle(fontSize: 13.0, color: Colors.grey[700]),
                ),
                const SizedBox(height: 2.0),
                Text(
                  sale.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.0, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
