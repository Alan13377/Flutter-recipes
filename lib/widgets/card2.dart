import 'package:flutter/material.dart';
import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/utils/theme.dart';
import 'package:fooderlich/widgets/author_card.dart';

class Card2 extends StatelessWidget {
  final ExploreRecipe recipe;
  const Card2({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),

        //*Columna que contendra la authorCard y los textos
        child: Column(
          children: [
            AuthorCard(
              authorName: recipe.authorName,
              title: recipe.title,
              imageProvider: AssetImage(recipe.profileImage),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      recipe.title,
                      style: FooderlichTheme.lightTextTheme.displayLarge,
                    ),
                  ),
                  //*Widget Rotated
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        recipe.subtitle,
                        style: FooderlichTheme.lightTextTheme.displayLarge,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
