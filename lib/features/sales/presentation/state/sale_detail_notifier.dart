import 'package:experience_app/features/sales/domain/repositories/sale_detail_repository.dart';
import 'package:experience_app/features/sales/data/repositories/sale_detail_repository_impl.dart';
import 'package:experience_app/features/sales/presentation/state/sale_detail_state.dart';
import 'package:riverpod/legacy.dart';

final saleDetailNotifierProvider = StateNotifierProvider.family
    .autoDispose<SaleDetailNotifier, SaleDetailState, String>(
      (ref, saleId) => SaleDetailNotifier(saleId: saleId),
    );

class SaleDetailNotifier extends StateNotifier<SaleDetailState> {
  SaleDetailNotifier({required this.saleId, SaleDetailRepository? repository})
    : _repository = repository ?? SaleDetailRepositoryImpl(),
      super(const SaleDetailState()) {
    loadSale();
  }

  final String saleId;
  final SaleDetailRepository _repository;

  Future<void> loadSale() async {
    final cleanSaleId = saleId.trim();
    if (cleanSaleId.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No se recibió el identificador de la venta.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final sale = await _repository.getSaleById(cleanSaleId);
    if (sale == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No se pudo encontrar la venta.',
      );
      return;
    }

    state = state.copyWith(sale: sale, isLoading: false, errorMessage: null);
  }
}
