import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/explore/data/models/product_model.dart';
import 'package:experience_app/features/explore/data/models/product_section_model.dart';

class ProductSectionsDataSource {
  final FirebaseFirestore _firestore;

  ProductSectionsDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ProductSectionModel>> getPreferredProducts() async {
    final snapshot = await _firestore.collection('products').get();
    final products = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.id, doc.data()))
        .toList();

    return [
      ProductSectionModel(title: 'Nuestros productos', products: products),
    ];
  }
}
