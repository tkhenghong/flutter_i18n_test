import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale locale) async {
    if (_appLocale == locale || locale == null || locale.languageCode == null) {
      return;
    }

    var prefs = await SharedPreferences.getInstance();

    _appLocale = Locale(locale.languageCode);
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode);

    notifyListeners();
  }
}
