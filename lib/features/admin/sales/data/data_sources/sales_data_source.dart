import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/admin/sales/data/models/sale_model.dart';

class SalesDataSource {
  final FirebaseFirestore _firestore;

  SalesDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<SaleModel>> watchSales() {
    return _firestore
        .collection('ventas')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SaleModel.fromFirestore(doc.id, doc.data()))
              .toList(),
        );
  }
}
