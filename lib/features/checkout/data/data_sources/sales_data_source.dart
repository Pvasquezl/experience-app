import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/checkout/domain/enums/payment_method.dart';
import 'package:experience_app/features/explore/domain/entities/cart_item_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SalesDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SalesDataSource({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  Future<void> createSale({
    required List<CartItemEntity> items,
    required String address,
    required PaymentMethod paymentMethod,
    required double total,
  }) async {
    final batch = _firestore.batch();
    final saleRef = _firestore.collection('ventas').doc();

    batch.set(saleRef, {
      'userId': _auth.currentUser?.uid,
      'address': address,
      'paymentMethod': paymentMethod.name,

      // Redondea a 2 decimales y lo guarda como número.
      'total': double.parse(total.toStringAsFixed(2)),

      'items': items
          .map(
            (item) => {
              'productId': item.id,
              'name': item.name,
              'image': item.image,
              'price': item.price,
              'quantity': item.quantity,
              'subtotal': item.subtotal,
            },
          )
          .toList(),

      'createdAt': FieldValue.serverTimestamp(),
    });

    for (final item in items) {
      final productRef = _firestore.collection('products').doc(item.id);

      batch.update(productRef, {
        'quantity': FieldValue.increment(-item.quantity),
      });
    }

    await batch.commit();
  }
}
