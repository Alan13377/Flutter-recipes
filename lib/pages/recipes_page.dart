import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/widgets/Recipe_page/recipes_gridview.dart';

class RecipesPage extends StatelessWidget {
  final exploreService = MockFooderlichService();
  RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
