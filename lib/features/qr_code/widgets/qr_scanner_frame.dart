import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerFrame extends StatefulWidget {
  final double frameSize;
  final double radius;
  final AnimationController animationController;
  final void Function(String raw) onDetect;
  final bool isScanning;

  const QRScannerFrame({
    super.key,
    required this.frameSize,
    required this.radius,
    required this.animationController,
    required this.onDetect,
    required this.isScanning,
  });

  @override
  State<QRScannerFrame> createState() => _QRScannerFrameState();
}

class _QRScannerFrameState extends State<QRScannerFrame> {
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QRScannerFrame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning) {
      _scannerController.start();
    } else {
      _scannerController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: SizedBox(
            width: widget.frameSize,
            height: widget.frameSize,
            child: MobileScanner(
              controller: _scannerController,
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  String? raw = barcode.rawValue;
                  if (raw == null) return;
                  if (widget.isScanning) widget.onDetect(raw);
                }
              },
            ),
          ),
        ),
        // Red corners
        ..._buildCorners(widget.frameSize),
        // Laser line
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (_, child) {
            return Positioned(
              top: widget.frameSize * widget.animationController.value,
              left: 0,
              child: Container(
                width: widget.frameSize,
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
