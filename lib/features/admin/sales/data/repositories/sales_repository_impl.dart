import 'package:experience_app/features/admin/sales/data/data_sources/sales_data_source.dart';
import 'package:experience_app/features/admin/sales/domain/entities/sale_entity.dart';
import 'package:experience_app/features/admin/sales/domain/repositories/sales_repository.dart';

class SalesRepositoryImpl implements SalesRepository {
  final SalesDataSource _dataSource;

  SalesRepositoryImpl({SalesDataSource? dataSource})
    : _dataSource = dataSource ?? SalesDataSource();

  @override
  Stream<List<SaleEntity>> watchSales() {
    return _dataSource.watchSales().map(
      (models) => models.map((model) => model.toEntity()).toList(),
    );
  }
}
