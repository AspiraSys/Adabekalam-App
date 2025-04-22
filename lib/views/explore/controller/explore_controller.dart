import 'package:flutter/material.dart';

class ExploreController extends ChangeNotifier{
  final List <String> _moods = [];
  final List <String> _selectedMoods = [];
  

  List <String> get moods => _moods;
  List <String> get selectedMoods => _selectedMoods;

  void toggleMoodSelection(String mood){
    if(_selectedMoods.contains(mood)){
      _selectedMoods.remove(mood);
    }else{
      _selectedMoods.add(mood);
    }
    notifyListeners();
  }

  void clearSelection(){
    _selectedMoods.clear();
    notifyListeners();
  }
}