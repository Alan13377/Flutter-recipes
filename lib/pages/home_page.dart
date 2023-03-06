import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/models/tab_manager.dart';
import 'package:fooderlich/pages/explore_page.dart';
import 'package:fooderlich/pages/grocery_page.dart';
import 'package:fooderlich/pages/recipes_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //*Pagina inicial
  // int selectedIndex = 0;
  late ExploreRecipe recipe;
  //*Lista de Paginas
  List pages = <Widget>[
    const ExplorerPage(),
    RecipesPage(),
    const GroceryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabManager = ref.watch(tabManagerProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fooderlich',
          style: theme.textTheme.titleLarge,
        ),
      ),

      //*Renderizamos las paginas segun el index del arreglo pages
      body: pages[tabManager.selectedIndex],

      //*Nvegacion
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.textSelectionTheme.selectionColor,

        //*Pagina Actual
        currentIndex: tabManager.selectedIndex,
        //*Funcion para navegar
        onTap: (index) => tabManager.navigateTo(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Recipes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Tu Buy",
          ),
        ],
      ),
    );
  }

  //*Funcion de navegacion
  // void navigateTo(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }
}
