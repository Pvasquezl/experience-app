import 'package:experience_app/features/sales/data/data_sources/sale_detail_data_source.dart';
import 'package:experience_app/features/sales/domain/repositories/sale_detail_repository.dart';

class SaleDetailRepositoryImpl implements SaleDetailRepository {
  SaleDetailRepositoryImpl({SaleDetailDataSource? dataSource})
    : _dataSource = dataSource ?? SaleDetailDataSource();

  final SaleDetailDataSource _dataSource;

  @override
  Future<Map<String, dynamic>?> getSaleById(String saleId) async {
    return _dataSource.getSaleById(saleId);
  }
}
