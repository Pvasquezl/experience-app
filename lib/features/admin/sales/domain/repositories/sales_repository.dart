import 'package:experience_app/features/admin/sales/domain/entities/sale_entity.dart';

abstract class SalesRepository {
  Stream<List<SaleEntity>> watchSales();
}
