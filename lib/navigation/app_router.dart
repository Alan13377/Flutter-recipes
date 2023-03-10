// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fooderlich/models/app_state_manager.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/pages/error_page.dart';
import 'package:fooderlich/pages/home_page.dart';
import 'package:fooderlich/pages/login_page.dart';
import 'package:fooderlich/pages/onboard_page.dart';
import 'package:fooderlich/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AppStateManager appStateManager;
  //*Obtener el perfil del usuario
  final ProfileManager profileManager;
  //*Administrar cuando el usuario crea o edita un articulo
  final GroceryManager groceryManager;

  AppRouter({
    required this.appStateManager,
    required this.profileManager,
    required this.groceryManager,
  });

  late final router = GoRouter(
      debugLogDiagnostics: true,
      //*Ruta inicial
      initialLocation: "/login",
      refreshListenable: appStateManager,
      routes: [
        //*Definimos las Rutas
        GoRoute(
          name: "login", //*nombre
          path: "/login", //*ruta
          builder: (context, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: "onboarding",
          path: "/onboarding",
          builder: (context, state) {
            return const OnboardingPage();
          },
        ),

        GoRoute(
            name: "home",
            //*Definimos una ruta con el parametro Tab
            path: "/:tab",
            builder: (contex, state) {
              //*Obtenemos el valor de la pestaña de los parametros
              final tab = int.tryParse(state.params["tab"] ?? "") ?? 0;
              //*Pasamos el parametro a la pagina
              return HomePage(key: state.pageKey, currentIndex: tab);
            },
            routes: [
              GoRoute(
                name: 'profile',
                // 1
                path: 'profile',
                builder: (context, state) {
                  // 2
                  final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
                  // 3
                  return ProfilePage(
                    user: profileManager.getUser,
                    currentTab: tab,
                  );
                },
                // 4
                routes: const [
                  // TODO: Add Webview subroute
                ],
              ),
            ]),
      ],

      //*Pagina de error si la ruta no se encuantra
      errorBuilder: ((context, state) {
        return ErrorPage(
          state: state,
        );
      }),

      //*Redirigir al login si el usuario
      redirect: (context, state) {
        //*Redirigir al login si el usuario esta logueado
        final loggedIn = appStateManager.isLoggedIn;
        //*Verficar si el usuario esta en la ruta /login
        final loggingIn = state.subloc == '/login';
        //*Si el usuario no esta logueado redirige al login
        if (!loggedIn) return loggingIn ? null : '/login';

        //*Redirigir al login si el usuario no ha completado el Onboarding
        final isOnboardingComplete = appStateManager.isOnboardingComplete;
        //*Comprobamos si el usuario esta en el Onboarding
        final onboarding = state.subloc == '/onboarding';
        //*Redirigimos al onboarding si el usuario no lo ha completado
        if (!isOnboardingComplete) {
          return onboarding ? null : '/onboarding';
        }

        //*Si se esta logueado y se completo el onboarding
        if (loggingIn || onboarding) {
          //*Redirigir a la pagina principal
          return '/${FooderlichTab.explore}';
        }
        //*Deja de redirigir
        return null;
      });
  // TODO: Add Redirect Handler
}
