import 'package:bikretaa/app/controller/notes_controller/notes_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Map<String, String> note;
  final int index;
  final NotesController controller;

  const NoteDetailsScreen({
    super.key,
    required this.note,
    required this.index,
    required this.controller,
  });

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController _headlineController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _headlineController = TextEditingController(text: widget.note["headline"]);
    _noteController = TextEditingController(text: widget.note["note"]);
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    String formattedDate = "";
    if (widget.note["date"] != null && widget.note["date"]!.isNotEmpty) {
      try {
        final dateTime = DateTime.parse(widget.note["date"]!);
        formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
      } catch (e) {
        formattedDate = widget.note["date"]!;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note Details',
          style: r.textStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(r.paddingextraSmall()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline
            Container(
              padding: EdgeInsets.symmetric(horizontal: r.paddingSmall()),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r.radiusMedium()),
              ),
              child: TextField(
                controller: _headlineController,
                decoration: const InputDecoration(
                  labelText: "Headline",
                  border: InputBorder.none,
                ),
                style: r.textStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            SizedBox(height: r.paddingMedium()),
            // Note
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.paddingSmall(),
                  vertical: r.paddingSmall() / 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                child: TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: "Note",
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                  ),
                  minLines: 1,
                  maxLines: 28,
                  style: r.textStyle(
                    fontSize: r.fontMedium(),
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(r.paddingSmall()),
        color: theme.cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Created/Updated: $formattedDate',
              style: r.textStyle(
                fontSize: r.fontSmall(),
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.paddingSmall()),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final updatedNote = {
                    "headline": _headlineController.text.trim(),
                    "note": _noteController.text.trim(),
                    "date": DateTime.now().toIso8601String(),
                  };
                  widget.controller.updateNote(widget.index, updatedNote);
                  Navigator.pop(context);
                },
                child: Text(
                  "Save",
                  style: r.textStyle(
                    fontSize: r.fontMedium(),
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
