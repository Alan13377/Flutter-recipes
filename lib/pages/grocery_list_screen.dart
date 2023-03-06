import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/pages/grocery_item_page.dart';
import 'package:fooderlich/widgets/grocery_tile.dart';

//*Lista de Productos agregados
class GroceryListPage extends ConsumerWidget {
  final GroceryManager manager;
  const GroceryListPage({super.key, required this.manager});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          //*Dismissible para borrar un elemento
          // 5

          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${item.name} dismissed"),
                ),
              );
            },
            child: InkWell(
              child: GroceryTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  }),
              // 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemPage(
                      originalItem: item,
                      // 3
                      onUpdate: (item) {
                        // 4
                        manager.updateItem(item, index);
                        // 5
                        Navigator.pop(context);
                      },
                      // 6
                      onCreate: (item) {},
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
