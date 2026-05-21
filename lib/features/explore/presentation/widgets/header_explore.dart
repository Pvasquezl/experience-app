import 'package:experience_app/features/explore/presentation/widgets/shopping_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderExplore extends StatelessWidget {
  const HeaderExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HeaderExplore();
  }
}

class _HeaderExplore extends ConsumerWidget {
  const _HeaderExplore();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0, left: 25.0, right: 25.0),
      child: Row(
        children: [
          Icon(Icons.search, size: 35.0),

          Spacer(),

          Icon(Icons.favorite_border,
              size: 32,
              color: Colors.black87),

          SizedBox(width: 12.0),

          ShoppingBagBadge(count: 15),
        ],
      ),
    );
  }
}