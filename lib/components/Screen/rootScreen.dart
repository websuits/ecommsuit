import 'package:flutter/material.dart';

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, Key? key}) : super(key: key);

  /// The label
  final String label;

  // /// The path to the detail page
  // final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            // TextButton(
            //   onPressed: () => context.go(detailsPath),
            //   child: const Text('View details'),
            // ),
          ],
        ),
      ),
    );
  }
}
