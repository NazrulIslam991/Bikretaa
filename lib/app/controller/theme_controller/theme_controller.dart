import 'package:bikretaa/app/app_theme.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  // Load theme mode from SharedPreferences
  void _loadThemeMode() async {
    bool savedTheme = await SharedPreferencesHelper.getThemeMode();
    isDarkMode.value = savedTheme;
    if (savedTheme) {
      Get.changeTheme(AppTheme.darkTheme);
    } else {
      Get.changeTheme(AppTheme.lightTheme);
    }
  }

  // Toggle theme
  void toggleTheme() async {
    if (isDarkMode.value) {
      Get.changeTheme(AppTheme.lightTheme);
      isDarkMode.value = false;
      await SharedPreferencesHelper.saveThemeMode(false);
    } else {
      Get.changeTheme(AppTheme.darkTheme);
      isDarkMode.value = true;
      await SharedPreferencesHelper.saveThemeMode(true);
    }
  }
}
