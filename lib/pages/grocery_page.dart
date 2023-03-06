import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/pages/empty_grocery_page.dart';
import 'package:fooderlich/pages/grocery_item_page.dart';
import 'package:fooderlich/pages/grocery_list_screen.dart';

//*Pagina que mostrara los items
class GroceryPage extends ConsumerWidget {
  const GroceryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(groceryManagerProvider);
    return Scaffold(
      //*Cuepo del Scaffold
      body: buildGroceryScreen(),

      //*Boton para agregar items
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GroceryItemPage(
                  onCreate: (item) {
                    manager.addItem(item);
                    Navigator.pop(context);
                  },
                  onUpdate: (item) {},
                );
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  //*Funcion para mostrar condicionalmente dos paginas
  Widget buildGroceryScreen() {
    return Consumer(
      builder: (context, ref, child) {
        final manager = ref.watch(groceryManagerProvider);
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListPage(
            manager: manager,
          );
        } else {
          return const EmptyGroceryPage();
        }
      },
    );
  }
}
