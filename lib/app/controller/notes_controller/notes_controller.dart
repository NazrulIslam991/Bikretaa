import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  var notes = <Map<String, String>>[].obs;

  var isSelectionMode = false.obs;
  var selectedIndexes = <int>[].obs;

  // for undo
  Map<String, String>? lastDeletedNote;
  int? lastDeletedIndex;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
    isSelectionMode.value = false;
    selectedIndexes.clear();
  }

  void addNote(String headline, String note) {
    final newNote = {
      "headline": headline,
      "note": note,
      "date": DateTime.now().toIso8601String(),
    };
    notes.insert(0, newNote);
    saveNotes();
  }

  // Update note at index
  void updateNote(int index, Map<String, String> updatedNote) {
    notes[index] = updatedNote;
    saveNotes();
  }

  // Single delete with undo
  void deleteSingle(int index) {
    lastDeletedNote = notes[index];
    lastDeletedIndex = index;
    notes.removeAt(index);
    saveNotes();
  }

  void undoDelete() {
    if (lastDeletedNote != null && lastDeletedIndex != null) {
      notes.insert(lastDeletedIndex!, lastDeletedNote!);
      saveNotes();
    }
    lastDeletedNote = null;
    lastDeletedIndex = null;
  }

  void deleteSelected() {
    if (selectedIndexes.isEmpty) return;

    selectedIndexes.sort((a, b) => b.compareTo(a));
    for (var index in selectedIndexes) {
      notes.removeAt(index);
    }

    selectedIndexes.clear();
    isSelectionMode.value = false;
    saveNotes();
  }

  void toggleSelectionMode() {
    if (isSelectionMode.value && selectedIndexes.isEmpty) {
      isSelectionMode.value = false;
    } else {
      isSelectionMode.value = !isSelectionMode.value;
      if (!isSelectionMode.value) selectedIndexes.clear();
    }
  }

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  void clearNotes() {
    notes.clear();
    saveNotes();
  }

  void saveNotes() {
    SharedPreferencesHelper.saveNotes(notes.toList());
  }

  void loadNotes() async {
    List<Map<String, String>> saved = await SharedPreferencesHelper.loadNotes();
    notes.assignAll(saved);
  }
}
