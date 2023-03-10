import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fooderlich/models/app_cache.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  //*Verificar si el usuario esta logueado

  bool _loggedIn = false;
  //*Verificar su el usuario a compmetado el onboarding
  bool _onboardingComplete = false;
  //* Registrar la pagina actual en la que se encuentra el usuario
  int _selectedTab = FooderlichTab.explore;
  //* Almacenar el estado del usuario en el sistema
  final _appCache = AppCache();

  //* Getters.
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  //* Inicializando la app
  Future<void> initializeApp() async {
    //* Checar si el usuario esta logueado
    _loggedIn = await _appCache.isUserLoggedIn();
    //*Verificar su el usuario a compmetado el onboarding
    _onboardingComplete = await _appCache.didCompleteOnboarding();
  }

  void login(String username, String password) async {
    _loggedIn = true;
    await _appCache.cacheUser();
    notifyListeners();
  }

  void onboarded() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() async {
    //* Resetear las propiedades al hacer logout
    _loggedIn = false;
    _onboardingComplete = false;
    _selectedTab = 0;

    //* Reinicializar la app
    await _appCache.invalidate();
    await initializeApp();
    notifyListeners();
  }
}

final appStateManagerProvider =
    ChangeNotifierProvider((ref) => AppStateManager());
