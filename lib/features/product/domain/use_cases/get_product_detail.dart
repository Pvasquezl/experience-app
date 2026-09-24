import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/domain/entities/product_detail_entity.dart';

class GetProductDetailUseCase {
  GetProductDetailUseCase({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<ProductDetailEntity> call(ProductEntity product) async {
    final snapshot = await _firestore
        .collection('products')
        .doc(product.id)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      return ProductDetailEntity.fromFirestore(snapshot.id, snapshot.data()!);
    }

    return ProductDetailEntity.fromProduct(product);
  }
}
