import 'package:flutter/material.dart';
import 'package:fooderlich/models/simple_recipe.dart';
import 'package:fooderlich/widgets/Recipe_page/recipe_thumbnail.dart';

class RecipesGridView extends StatelessWidget {
  final List<SimpleRecipe> recipes;
  const RecipesGridView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: GridView.builder(
          itemCount: recipes.length,
          //*Establece el numero de Columnas
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final simpleRecipe = recipes[index];
            return RecipeThumbnail(recipe: simpleRecipe);
          }),
    );
  }
}
