import 'package:experience_app/features/admin/sales/domain/entities/sale_entity.dart';
import 'package:experience_app/features/admin/sales/domain/use_cases/watch_sales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final salesStreamProvider = StreamProvider.autoDispose<List<SaleEntity>>((ref) {
  return WatchSalesUseCase().call();
});
