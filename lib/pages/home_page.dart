import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/pages/explore_page.dart';
import 'package:fooderlich/pages/grocery_page.dart';
import 'package:fooderlich/pages/recipes_page.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  //*Index actual
  final int currentIndex;
  const HomePage({super.key, required this.currentIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //*Lista de Paginas
  List<Widget> pages = <Widget>[
    const ExplorerPage(),
    RecipesPage(),
    const GroceryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabManager = ref.watch(appStateManagerProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          profileButton(widget.currentIndex),
        ],
      ),

      //*Renderizamos el body segun el indice del arreglo
      //*IndexStack permite conservar el estado al cambiar entre paginas
      body: IndexedStack(
        index: widget.currentIndex,
        children: pages,
      ),

      //*Navegacion
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.textSelectionTheme.selectionColor,
        //*Index Actual
        currentIndex: widget.currentIndex,
        onTap: (index) {
          //*Actualiza la pestaña que el usuario selecciono
          tabManager.goToTab(index);

          //*Navegacion segun la pestaña seleccionada
          //*GoRouter
          context.goNamed(
            "home",
            params: {
              "tab": "$index",
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To Buy',
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

  Widget profileButton(int currentTab) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          context.goNamed(
            'profile',
            params: {
              'tab': '$currentTab',
            },
          );
        },
      ),
    );
  }
}
