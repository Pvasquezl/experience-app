import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProductView();
  }

}


class _ProductView extends ConsumerWidget{
  const _ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Product View'),
      ),
    );
  }
}