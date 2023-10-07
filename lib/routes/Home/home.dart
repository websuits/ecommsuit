import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Home Screen')),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () => context.go('/categories'),
      //     child: const Text('Go to the Details screen'),
      //   ),
      // ),
    );
  }
}