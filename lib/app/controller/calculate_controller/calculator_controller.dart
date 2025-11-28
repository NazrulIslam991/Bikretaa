import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var historyList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  // Add a new calculation to history
  void addHistory(String entry) {
    historyList.add(entry);
    saveHistory();
  }

  // Clear all history
  void clearHistory() {
    historyList.clear();
    saveHistory();
  }

  // Save to SharedPreferences via helper
  void saveHistory() {
    SharedPreferencesHelper.saveCalcHistory(historyList.toList());
  }

  // Load from SharedPreferences via helper
  void loadHistory() async {
    List<String> saved = await SharedPreferencesHelper.loadCalcHistory();
    historyList.assignAll(saved);
  }
}
