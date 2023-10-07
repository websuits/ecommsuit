import 'package:flutter/material.dart';

/// Widget for the root/initial pages in the bottom navigation bar.
class DummyScreen extends StatelessWidget {
  /// Creates a DummyScreen
  const DummyScreen({Key? key}) : super(key: key);

  // /// The path to the detail page
  // final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('', style: Theme.of(context).textTheme.titleLarge),
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
