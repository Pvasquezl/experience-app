import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: const Center(
        child: Text(
          'Onboarding View',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
