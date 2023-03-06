import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabManager extends ChangeNotifier {
  int selectedIndex = 0;

  void navigateTo(index) {
    selectedIndex = index;
    notifyListeners();
  }

  void goToRecipes() {
    selectedIndex = 1;
    notifyListeners();
  }
}

final tabManagerProvider = ChangeNotifierProvider<TabManager>((ref) {
  return TabManager();
});
