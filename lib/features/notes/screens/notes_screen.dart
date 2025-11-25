import 'dart:async';

import 'package:bikretaa/app/controller/notes_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/notes/widgets/add_note_dialog.dart';
import 'package:bikretaa/features/notes/widgets/note_item_widgets.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  static const name = '/Notes';

  final NotesController controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    controller.isSelectionMode.value = false;
    controller.selectedIndexes.clear();

    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Notes',
          style: r.textStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          Obx(() {
            if (controller.isSelectionMode.value) {
              final hasSelected = controller.selectedIndexes.isNotEmpty;
              return IconButton(
                icon: Icon(
                  Icons.delete,
                  color: hasSelected
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface,
                  size: r.iconMedium(),
                ),
                onPressed: hasSelected
                    ? () => _confirmDeleteSelected(context)
                    : controller.toggleSelectionMode,
              );
            } else {
              return IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: theme.colorScheme.onSurface,
                  size: r.iconMedium(),
                ),
                onPressed: controller.toggleSelectionMode,
              );
            }
          }),
        ],
      ),
      body: Obx(() {
        if (controller.notes.isEmpty) {
          return Center(
            child: Text(
              'No notes yet. Tap to add!',
              style: r.textStyle(
                fontSize: r.fontMedium(),
                color: theme.colorScheme.primary,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(r.paddingMedium()),
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return NoteItem(
              note: note,
              index: index,
              controller: controller,
              responsive: r,
              theme: theme,
              onDeleteWithUndo: _deleteWithUndo,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SingleChildScrollView(
                child: AddNoteWidget(
                  controller: controller,
                  responsive: r,
                  theme: theme,
                ),
              ),
            ),
          );
        },
        backgroundColor: theme.colorScheme.secondary,
        child: Icon(
          Icons.add,
          size: r.iconLarge(),
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }

  Future<bool> _deleteWithUndo(BuildContext context, int index) async {
    controller.deleteSingle(index);

    int seconds = 10;
    late Timer timer;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      duration: const Duration(seconds: 10),
      content: StatefulBuilder(
        builder: (context, setState) {
          timer = Timer.periodic(const Duration(seconds: 1), (_) {
            if (seconds > 1) {
              seconds--;
              setState(() {});
            }
          });
          return Text("Note deleted. Undo in $seconds sec");
        },
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          timer.cancel();
          controller.undoDelete();
        },
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(snackBar).closed.then((_) => timer.cancel());
    return false;
  }

  Future<void> _confirmDeleteSelected(BuildContext context) async {
    bool confirmed = await showConfirmDialog(
      context: context,
      title: "Delete Notes",
      content: "Are you sure?",
      confirmText: "Delete",
      confirmColor: Theme.of(context).colorScheme.error,
    );

    if (confirmed) controller.deleteSelected();
  }
}
