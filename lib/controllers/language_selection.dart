import 'package:flutter/material.dart';

import '../utils/logger.dart';

class LanguageProvider extends ChangeNotifier {
  String selectedLanguage = "ENGLISH";

  void selectLang(String lang) {
    selectedLanguage = lang.toUpperCase();
    logger.i("Selected Language: $selectedLanguage");
    notifyListeners();
  }
}
