import 'package:cloud_firestore/cloud_firestore.dart';

class SaleDetailDataSource {
  SaleDetailDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<Map<String, dynamic>?> getSaleById(String saleId) async {
    final cleanedSaleId = saleId.trim();
    if (cleanedSaleId.isEmpty) {
      return null;
    }

    final byDocumentId = await _firestore
        .collection('ventas')
        .doc(cleanedSaleId)
        .get();
    if (byDocumentId.exists && byDocumentId.data() != null) {
      final data = byDocumentId.data()!;
      return {...data, 'id': byDocumentId.id};
    }

    final byField = await _firestore
        .collection('ventas')
        .where('sale_id', isEqualTo: cleanedSaleId)
        .limit(1)
        .get();

    if (byField.docs.isEmpty) {
      return null;
    }

    final doc = byField.docs.first;
    return {...doc.data(), 'id': doc.id};
  }
}
