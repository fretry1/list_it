import 'package:flutter/material.dart';

import '../model/category.dart';

class CategorySelectionPage extends StatelessWidget {
  final Category initialCategory;

  const CategorySelectionPage({super.key, required this.initialCategory});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Category'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Default'),
              Tab(text: 'Custom'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: Category.defaults.length,
              itemBuilder: (context, index) {
                final category = Category.defaults.values.elementAt(index);
                return ListTile(
                  leading: Icon(Icons.satellite), // TODO: fix category
                  title: Text(category.title),
                  onTap: () {
                    Navigator.pop(context, category);
                  },
                );
              },
            ),
            // TODO: implement custom categories
            const Center(child: Text('Not implemented yet...')),
          ],
        ),
      ),
    );
  }
}