import 'package:flutter/material.dart';

class ExperiencePersonalitationView extends StatelessWidget {
  const ExperiencePersonalitationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          "Experience Personalitation",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
