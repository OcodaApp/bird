import 'dart:ui';
import 'package:get/get.dart';
import 'langs/ar.dart';
import 'langs/en.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale =  Locale('ar', 'EG');
  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale =  Locale('ar', 'EG');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'عربي',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'EG'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar_EG': ar,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
