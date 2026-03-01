import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QRService {
  /// Generate QR code data from a Map of field-value pairs
  static String generateQRData(Map<String, String> productInfo) {
    final infoString = productInfo.entries
        .map((e) => "${e.key}: ${e.value}")
        .join("\n");
    final encoded = Uri.encodeComponent(infoString);
    return "productinfo://$encoded";
  }

  /// Capture widget as image bytes
  static Future<Uint8List?> captureQRCode(GlobalKey qrKey) async {
    try {
      final boundary = qrKey.currentContext?.findRenderObject();
      if (boundary != null) {
        final screenshotController = ScreenshotController();
        return await screenshotController.captureFromWidget(
          RepaintBoundary(
            key: qrKey,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                data: "sample",
                version: QrVersions.auto,
                size: 200,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error capturing QR: $e");
    }
    return null;
  }

  /// Save QR image bytes to gallery
  static Future<bool> saveQRCode(Uint8List imageBytes) async {
    final result = await ImageGallerySaverPlus.saveImage(
      imageBytes,
      quality: 100,
      name: "qr_${DateTime.now().millisecondsSinceEpoch}",
    );
    return result['isSuccess'] == true;
  }
}
