import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/navigation/app_router.dart';
import 'package:fooderlich/utils/theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(
        appStateManager: appStateManager,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final AppStateManager appStateManager;
  late final profileManager = ProfileManager();
  late final groceryManager = GroceryManager();

  //*Inicializamos GoRouter
  late final appRouter = AppRouter(
    appStateManager: appStateManager,
    profileManager: profileManager,
    groceryManager: groceryManager,
  );

  MyApp({
    super.key,
    required this.appStateManager,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryManager = ref.watch(groceryManagerProvider);
    final profileManager = ref.watch(profileManagerProvider);
    final router = appRouter.router;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fooderlich',
      theme: profileManager.darkMode
          ? FooderlichTheme.dark()
          : FooderlichTheme.light(),
      //*Configuramos las rutas

      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
