import 'package:flutter/material.dart';
import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/pages/explore_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //*Pagina inicial
  int selectedIndex = 0;
  late ExploreRecipe recipe;
  //*Lista de Paginas
  List pages = <Widget>[
    ExplorerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fooderlich',
          style: theme.textTheme.titleLarge,
        ),
      ),

      //*Renderizamos las paginas segun el index
      body: pages[selectedIndex],

      //*Nvegacion
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.textSelectionTheme.selectionColor,
        currentIndex: selectedIndex,
        onTap: navigateTo,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Card",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Card2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Card3",
          ),
        ],
      ),
    );
  }

  //*Funcion de navegacion
  void navigateTo(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
