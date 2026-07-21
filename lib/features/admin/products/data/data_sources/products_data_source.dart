import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/admin/products/data/models/product_model.dart';

class ProductsDataSource {
  final FirebaseFirestore _firestore;

  ProductsDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('products');

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.id, doc.data()))
        .toList();
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final docRef = await _collection.add(product.toJson());
    return ProductModel.fromJson(docRef.id, product.toJson());
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    await _collection.doc(product.id).update(product.toJson());
    return product;
  }

  Future<void> deleteProduct(String id) async {
    await _collection.doc(id).delete();
  }
}
