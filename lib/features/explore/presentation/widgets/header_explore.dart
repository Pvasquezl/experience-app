import 'package:experience_app/features/explore/presentation/widgets/shopping_badge.dart';
import 'package:flutter/material.dart';

class HeaderExplore extends StatelessWidget {
  const HeaderExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HeaderExplore();
  }
}

class _HeaderExplore extends StatelessWidget {
  const _HeaderExplore();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0, left: 25.0, right: 25.0),
      child: Row(
        children: [Spacer(), SizedBox(width: 12.0), ShoppingBagBadge()],
      ),
    );
  }
}
