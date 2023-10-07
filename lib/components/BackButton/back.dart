import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBackButton extends StatelessWidget {
  final GoRouter goRouter;
  final String targetRoute;

  MyBackButton({required this.goRouter, required this.targetRoute});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Use GoRouter to navigate back to the target route
        // goRouter.go(targetRoute);
      },
    );
  }
}
