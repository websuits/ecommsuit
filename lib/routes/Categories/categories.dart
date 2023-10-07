import 'package:flutter/material.dart';
import 'package:eCommSuit/services/magento_service.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final MagentoService magentoService = MagentoService();
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    // Fetch categories when the widget is initialized
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final accessToken = await magentoService.getAccessToken();
      final categoryData = await magentoService.getCategories(accessToken);
      setState(() {
        categories = categoryData['children_data'] ?? []; // Assuming categories are in 'items' field
      });
    } catch (e) {
      // Handle errors
      print('Error fetching token for categories: $e');
    }
  }

  Widget buildCategoryTree(List<dynamic> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category['name']),
          // If there are children categories, show an ExpansionTile
          // and recursively call buildCategoryTree for children.
          // Otherwise, show an empty container.
          subtitle: category['children_data'].isEmpty
              ? Container()
              : buildCategoryTree(category['children_data']),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          final categoryName = category['name'];
          final subcategories = category['children_data'] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(categoryName),
                // Add onTap behavior if needed
              ),
              if (subcategories.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subcategories.length,
                    itemBuilder: (context, subIndex) {
                      final subcategory = subcategories[subIndex];
                      final subcategoryName = subcategory['name'];
                      final categoryId = subcategory['id'];
                      final parentId = subcategory['parent_id'];

                      return ListTile(
                        title: Text(subcategoryName),
                        // Add onTap behavior if needed for subcategories
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}