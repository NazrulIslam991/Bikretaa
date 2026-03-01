import 'package:bikretaa/app/controller/notes_controller/notes_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../screens/notes_details_screen.dart';

class NoteItem extends StatelessWidget {
  final Map<String, String> note;
  final int index;
  final NotesController controller;
  final Responsive responsive;
  final ThemeData theme;
  final Future<bool> Function(BuildContext, int) onDeleteWithUndo;

  const NoteItem({
    super.key,
    required this.note,
    required this.index,
    required this.controller,
    required this.responsive,
    required this.theme,
    required this.onDeleteWithUndo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.paddingSmall()),
      child: Dismissible(
        key: ValueKey(note["date"]),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: EdgeInsets.only(right: responsive.paddingMedium()),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: theme.colorScheme.error,
            borderRadius: BorderRadius.circular(responsive.radiusMedium()),
          ),
          child: Icon(
            Icons.delete,
            color: theme.colorScheme.onError,
            size: responsive.iconMedium(),
          ),
        ),
        confirmDismiss: (_) => onDeleteWithUndo(context, index),
        child: GestureDetector(
          onTap: () {
            if (controller.isSelectionMode.value) {
              controller.toggleSelection(index);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteDetailsScreen(
                    note: controller.notes[index],
                    index: index,
                    controller: controller,
                  ),
                ),
              );
            }
          },
          onLongPress: () {
            controller.isSelectionMode.value = true;
            controller.toggleSelection(index);
          },
          child: Obx(() {
            final selected = controller.selectedIndexes.contains(index);
            return Container(
              padding: EdgeInsets.all(responsive.paddingMedium()),
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.95),
                borderRadius: BorderRadius.circular(responsive.radiusMedium()),
                boxShadow: [
                  BoxShadow(
                    color: theme.brightness == Brightness.light
                        ? Colors.black26
                        : Colors.black54,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note["headline"] ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: responsive.textStyle(
                            fontSize: responsive.fontLarge(),
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: responsive.paddingextraSmall()),
                        Text(
                          note["note"] ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: responsive.textStyle(
                            fontSize: responsive.fontSmall(),
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: responsive.paddingextraSmall()),
                        Text(
                          DateFormat(
                            'dd MMM yyyy, hh:mm a',
                          ).format(DateTime.parse(note["date"]!)),
                          style: responsive.textStyle(
                            fontSize: responsive.fontmediumSmall(),
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.isSelectionMode.value)
                    Checkbox(
                      value: selected,
                      onChanged: (_) => controller.toggleSelection(index),
                      fillColor: MaterialStateProperty.all(
                        theme.colorScheme.secondary,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
