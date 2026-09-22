import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/explore/data/models/preferred_products_model.dart';

class PreferredProductsDataSource {
  final FirebaseFirestore _firestore;

  PreferredProductsDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<PreferredProductsModel>> getPreferredProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .where('favorite', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((doc) => PreferredProductsModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }
}
