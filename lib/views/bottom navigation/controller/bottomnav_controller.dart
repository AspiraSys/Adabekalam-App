import 'package:flutter/material.dart';
import 'package:shayari_app/views/home/home_screen.dart';

import '../../collection/collection_page.dart';
import '../../favorite/favorite.dart';


class BottomNavController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> _screens = [
    CollectionPage(),
    HomeScreen(),
    Favorite(),
    // PoetProfile(image: '', language: '', name: '',)



  ];

  Widget get currentScreen => _screens[_selectedIndex];
  
  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
