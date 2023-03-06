import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/groove_manager.dart';
import 'package:fooderlich/pages/empty_grocery_page.dart';
import 'package:fooderlich/pages/grocery_item_page.dart';

class GroceryPage extends ConsumerWidget {
  const GroceryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(grooveManagerProvider);
    return Scaffold(
      //*Cuepo del Scaffold
      body: buildGroceryScreen(),
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

  Widget buildGroceryScreen() {
    return Consumer(
      builder: (context, ref, child) {
        final manager = ref.watch(grooveManagerProvider);
        if (manager.groceryItems.isNotEmpty) {
          return Container();
        } else {
          return const EmptyGroceryPage();
        }
      },
    );
  }
}
