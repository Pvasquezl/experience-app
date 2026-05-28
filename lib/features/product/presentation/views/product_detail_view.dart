import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/features/explore/domain/entities/product_entity.dart';
import 'package:experience_app/features/product/presentation/state/product_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailView extends ConsumerWidget {
  const ProductDetailView({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailNotifierProvider(product));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        context.goNamed(Routes.explore);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Product Detail - ID: ${product.id}')),
        body: Center(child: Text('Details for product with ID: ${product.id}')),
      ),
    );
  }
}
