import 'package:flutter/material.dart';

class PageViewController extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


 int _currentProfileIndex = 0;
int get currentProfileIndex => _currentProfileIndex;


  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  
  void changeProfileIndex(int index) {
    _currentProfileIndex = index;
    notifyListeners();
  }
}
