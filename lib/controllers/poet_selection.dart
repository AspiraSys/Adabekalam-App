import 'package:flutter/material.dart';

class PoetSelection extends ChangeNotifier {
  int selectedIndex = 0;
  String selectedPoet = 'ALL';

  void togglePoetSelection(int index, String poetName) {
    if (selectedIndex == index) {
      return; 
    }
    selectedPoet = poetName;
    selectedIndex = index;
    notifyListeners();
  }

  bool isPoetSelected(int index) {
    return selectedIndex == index;
  }


}

