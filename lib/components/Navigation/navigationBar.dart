import 'package:flutter/material.dart';

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    Key? key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // Ensure that selectedIndex is within the valid range
    final validSelectedIndex = selectedIndex.clamp(0, 1);

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: validSelectedIndex, // Use the valid index
        destinations: const [
          NavigationDestination(label: 'Home', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Categories', icon: Icon(Icons.manage_search)),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}