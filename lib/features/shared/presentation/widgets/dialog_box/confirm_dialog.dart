import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String cancelText = "Cancel",
  String confirmText = "Confirm",
  Color confirmColor = Colors.red,
}) async {
  final theme = Theme.of(context);
  final r = Responsive.of(context);

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusLarge()),
      ),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(r.width(0.05)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: r.textStyle(
                fontSize: r.fontXL(),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.height(0.02)),

            // Content
            Text(
              content,
              textAlign: TextAlign.center,
              style: r.textStyle(fontSize: r.fontMedium(), color: Colors.black),
            ),
            SizedBox(height: r.height(0.03)),

            // Buttons
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusMedium()),
                      ),
                      side: BorderSide(color: theme.colorScheme.primary),
                      padding: EdgeInsets.symmetric(vertical: r.height(0.02)),
                    ),
                    child: Text(
                      cancelText.tr,
                      style: r.textStyle(
                        fontSize: r.fontMedium(),
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: r.width(0.03)),

                // Confirm Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(r.radiusMedium()),
                      ),
                      padding: EdgeInsets.symmetric(vertical: r.height(0.02)),
                    ),
                    child: Text(
                      confirmText.tr,
                      style: r.textStyle(
                        fontSize: r.fontMedium(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  return result ?? false;
}
