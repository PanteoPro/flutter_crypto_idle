import 'package:crypto_tycoon/domain/data_providers/settings_data_provider.dart';
import 'package:flutter/material.dart';

class MainAppViewModel extends ChangeNotifier {
  MainAppViewModel() {
    _settingsDataProvider = SettingsDataProvider();
    _settingsDataProvider.init().then((value) {
      final localeString = _settingsDataProvider.getLocale();
      if (localeString != null) {
        _changeLocale(Locale(localeString));
      }
    });
  }

  Locale locale = const Locale('ru');
  late SettingsDataProvider _settingsDataProvider;

  void _changeLocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
    _settingsDataProvider.saveLocale(locale.languageCode);
  }

  void setLocaleRu() {
    _changeLocale(const Locale('ru'));
  }

  void setLocaleEn() {
    _changeLocale(const Locale('en'));
  }
}
