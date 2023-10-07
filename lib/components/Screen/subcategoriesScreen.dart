import 'package:flutter/material.dart';

class SubcategoriesScreen extends StatelessWidget {
  // final String? categoryName;
  // final String? subcategoryName;
  final String? categoryId;
  final String? parentId;

  const SubcategoriesScreen({Key? key, required this.categoryId, required this.parentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Products"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          SizedBox(height: 16),
          Text("Category Name: $parentId"),
          Text("Subcategoty Name: $categoryId")
        ],
      ),
    );
  }
}