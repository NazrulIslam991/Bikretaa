import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:get/get.dart';

class QuickActionController extends GetxController {
  // Reactive list of selected indexes
  var selectedIndexes = <int>[].obs;

  // Default quick actions to show when app is first installed
  final List<int> defaultIndexes = [0, 1, 2, 3];

  @override
  void onInit() {
    super.onInit();
    _loadSelectedIndexes();
  }

  // Load saved indexes from SharedPreferences
  void _loadSelectedIndexes() async {
    List<int>? savedIndexes = await SharedPreferencesHelper.getQuickActions();
    if (savedIndexes == null || savedIndexes.isEmpty) {
      selectedIndexes.value = defaultIndexes;
    } else {
      selectedIndexes.value = savedIndexes;
    }
  }

  // Update selected indexes and save persistently
  void updateSelection(List<int> indexes) async {
    selectedIndexes.value = indexes;
    await SharedPreferencesHelper.saveQuickActions(indexes);
  }
}
