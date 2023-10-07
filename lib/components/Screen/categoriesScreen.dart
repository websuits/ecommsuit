import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eCommSuit/services/magento_service.dart';

/// The Categories screen for either the A or B screen.
class CategoriesScreen extends StatefulWidget {
  /// Constructs a [CategoriesScreen].
  const CategoriesScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => CategoriesScreenState();
}

/// The state for CategoriesScreen
class CategoriesScreenState extends State<CategoriesScreen> {
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
        categories = categoryData['children_data'] ??
            []; // Assuming categories are in 'items' field
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
        title: Text('Categories Screen - ${widget.label}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: categories.map<Widget>((category) {
            final categoryName = category['name'];
            final subcategories = category['children_data'] ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: Text(categoryName),
                  children: subcategories.map<Widget>((subcategory) {
                    final subcategoryName = subcategory['name'];
                    final categoryId = subcategory['id'];
                    final parentId = subcategory['parent_id'];
                    return ListTile(
                      title: GestureDetector(
                        onTap: () {
                          final goRouterState = GoRouter.of(context);
                          goRouterState.go(
                            '/categories/$parentId/$categoryId',
                            // Pass the parameters in the extra map
                            extra: {
                              // 'categoryName': categoryName,
                              // 'subcategoryName': subcategoryName,
                              'categoryId': categoryId,
                              'parentId': parentId
                            },
                          );
                        },
                        child: Text(subcategoryName),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
