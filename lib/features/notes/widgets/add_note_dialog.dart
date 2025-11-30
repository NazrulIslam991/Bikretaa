import 'package:bikretaa/app/controller/notes_controller/notes_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNoteWidget extends StatefulWidget {
  final NotesController controller;
  final Responsive responsive;
  final ThemeData theme;

  const AddNoteWidget({
    super.key,
    required this.controller,
    required this.responsive,
    required this.theme,
  });

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  final _headlineController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _headlineController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.responsive;
    final theme = widget.theme;

    return Padding(
      padding: EdgeInsets.only(
        left: r.paddingextraSmall(),
        right: r.paddingextraSmall(),
        top: r.paddingMedium(),
        bottom: r.paddingextraSmall(),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "add_new_note".tr,
              style: r.textStyle(
                fontSize: r.fontLarge(),
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: r.paddingMedium()),
            TextFormField(
              controller: _headlineController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "headline_hint".tr,
                hintStyle: TextStyle(color: theme.hintColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "headline_empty".tr;
                }
                return null;
              },
            ),
            SizedBox(height: r.paddingMedium()),
            TextFormField(
              controller: _noteController,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "note_hint".tr,
                hintStyle: TextStyle(color: theme.hintColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "note_empty".tr; // localized
                }
                return null;
              },
            ),
            SizedBox(height: r.paddingMedium()),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.controller.addNote(
                    _headlineController.text.trim(),
                    _noteController.text.trim(),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(
                "add".tr,
                style: r.textStyle(
                  fontSize: r.fontMedium(),
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
