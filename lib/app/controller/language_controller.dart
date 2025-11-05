import 'dart:ui';

import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  Locale _currentLocale = const Locale('en', 'US');
  final List<Locale> _supportedLocales = const [
    Locale('en', 'US'),
    Locale('bn', 'BD'),
  ];

  Locale get currentLocale => _currentLocale;
  List<Locale> get supportedLocales => _supportedLocales;

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  // Load saved language
  void _loadLanguage() async {
    String savedLang = await SharedPreferencesHelper.getLanguage();
    _currentLocale = savedLang == 'bn'
        ? const Locale('bn', 'BD')
        : const Locale('en', 'US');
    Get.updateLocale(_currentLocale);
    update();
  }

  // Change language
  void changeLocale(Locale locale) async {
    _currentLocale = locale;
    Get.updateLocale(locale);
    await SharedPreferencesHelper.saveLanguage(locale.languageCode);
    update();
  }
}
