import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeeMoreSpace extends StatelessWidget {
  final String _title;
  final String _route;
  const SeeMoreSpace({super.key, required String title, required String route})
    : _title = title,
      _route = route;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            context.goNamed(_route);
          },
          child: const Text(
            "See more",
            style: TextStyle(color: Color(0xFF006FFD)),
          ),
        ),
      ],
    );
  }
}
