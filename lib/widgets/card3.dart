import 'package:flutter/material.dart';
import 'package:fooderlich/utils/theme.dart';

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      //*Container con una imagen de fondo
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mag2.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        //*stack que contendra un container que añadira un overlay a la tarjeta principal
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          // TODO: Add Container, Column, Icon and Text
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Recipe Trends",
                  style: FooderlichTheme.darkTextTheme.displayMedium,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          // TODO: Add Center widget with Chip widget children  // TODO: Add dark overlay BoxDecoration
          Center(
            //*Grap para permite pasar a la siguiente linea si no hay espacio
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 12,
              runSpacing: 12,
              children: [
                Chip(
                  label: Text(
                    "Healthy",
                    style: FooderlichTheme.darkTextTheme.bodyLarge,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  onDeleted: () {
                    print("Delete");
                  },
                ),
                Chip(
                  label: Text(
                    "Vegan",
                    style: FooderlichTheme.darkTextTheme.bodyLarge,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  onDeleted: () {
                    print("Delete");
                  },
                ),
                Chip(
                  label: Text(
                    "Carrots",
                    style: FooderlichTheme.darkTextTheme.bodyLarge,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
