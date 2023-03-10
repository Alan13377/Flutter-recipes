import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/tab_manager.dart';
import 'package:go_router/go_router.dart';

class EmptyGroceryPage extends ConsumerWidget {
  const EmptyGroceryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerTab = ref.read(tabManagerProvider);
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset("assets/fooderlich_assets/empty_list.png"),
              ),
            ),
            Text(
              "No Groceries",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.green,
              onPressed: () {
                const index = FooderlichTab.recipes;
                //*Con GoRouter navegamos al indice 1
                context.goNamed(
                  "home",
                  params: {
                    "tab": "$index",
                  },
                );
              },
              child: const Text(
                "Browse Recipes",
              ),
            )
          ],
        ),
      ),
    );
  }
}
