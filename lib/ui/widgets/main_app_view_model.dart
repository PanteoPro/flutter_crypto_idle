import 'package:flutter/material.dart';

class MainAppViewModel extends ChangeNotifier {
  Locale locale = const Locale('ru');

  void _changeLocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }

  void setLocaleRu() {
    _changeLocale(const Locale('ru'));
  }

  void setLocaleEn() {
    _changeLocale(const Locale('en'));
  }
}
