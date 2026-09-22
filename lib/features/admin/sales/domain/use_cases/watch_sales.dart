import 'package:experience_app/features/admin/sales/data/repositories/sales_repository_impl.dart';
import 'package:experience_app/features/admin/sales/domain/entities/sale_entity.dart';
import 'package:experience_app/features/admin/sales/domain/repositories/sales_repository.dart';

class WatchSalesUseCase {
  final SalesRepository _repository;

  WatchSalesUseCase({SalesRepository? repository})
    : _repository = repository ?? SalesRepositoryImpl();

  Stream<List<SaleEntity>> call() {
    return _repository.watchSales();
  }
}
