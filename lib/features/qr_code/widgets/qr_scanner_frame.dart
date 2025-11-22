import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerFrame extends StatelessWidget {
  final double frameSize;
  final double radius;
  final AnimationController animationController;
  final void Function(String raw) onDetect;

  const QRScannerFrame({
    super.key,
    required this.frameSize,
    required this.radius,
    required this.animationController,
    required this.onDetect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            width: frameSize,
            height: frameSize,
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
              ),
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  String? raw = barcode.rawValue;
                  if (raw == null) return;
                  onDetect(raw);
                }
              },
            ),
          ),
        ),
        // Red corners
        ..._buildCorners(frameSize),
        // Laser line
        AnimatedBuilder(
          animation: animationController,
          builder: (_, child) {
            return Positioned(
              top: frameSize * animationController.value,
              left: 0,
              child: Container(
                width: frameSize,
                height: 3,
                color: Colors.redAccent.withOpacity(0.8),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildCorners(double frameSize) {
    const double cornerThickness = 4.0;
    final double cornerLength = frameSize * 0.2;

    return [
      // Top-left
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: Colors.redAccent,
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: Colors.redAccent,
        ),
      ),
      // Top-right
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: Colors.redAccent,
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: Colors.redAccent,
        ),
      ),
      // Bottom-left
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: Colors.redAccent,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: Colors.redAccent,
        ),
      ),
      // Bottom-right
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: Colors.redAccent,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: Colors.redAccent,
        ),
      ),
    ];
  }
}
