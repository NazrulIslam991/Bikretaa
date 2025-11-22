import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/qr_code/widgets/qr_scanner_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});
  static const name = '/qr_Code_scanner';

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  String? scannedUrl;
  bool isScanning = true;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String text) =>
      text.startsWith("http://") || text.startsWith("https://");

  Future<void> _openUrl(String urlText) async {
    final url = Uri.parse(urlText);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid URL")));
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied URL")));
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    final double frameSize = r.width(0.55);

    final backgroundColor = theme.scaffoldBackgroundColor;
    final textColor = theme.textTheme.titleSmall?.color ?? Colors.black;
    final cardColor = theme.cardColor;
    final buttonColor =
        theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
        Colors.redAccent;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "QR Code Scanner",
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(r.paddingMedium()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Reusable QR Scanner Frame
                QRScannerFrame(
                  frameSize: frameSize,
                  radius: r.radiusLarge(),
                  animationController: _animationController,
                  onDetect: (raw) {
                    if (_isValidUrl(raw)) {
                      setState(() {
                        scannedUrl = raw;
                        isScanning = false;
                      });
                    }
                  },
                ),

                SizedBox(height: r.height(0.05)),

                // Scanned URL Card
                if (scannedUrl != null)
                  Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(r.radiusMedium()),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: r.height(0.005),
                        horizontal: r.width(0.04),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              scannedUrl!,
                              style: TextStyle(
                                fontSize: r.fontSmall(),
                                color: textColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _copyToClipboard(scannedUrl!),
                            icon: Icon(Icons.copy, size: r.iconSmall()),
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: r.height(0.03)),

                // Open URL Button
                if (scannedUrl != null)
                  ElevatedButton.icon(
                    onPressed: () => _openUrl(scannedUrl!),
                    icon: Icon(Icons.open_in_browser, size: r.iconSmall()),
                    label: Text(
                      "Open URL",
                      style: TextStyle(fontSize: r.fontSmall()),
                    ),
                  ),

                SizedBox(height: r.height(0.01)),

                // Scan Again Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      scannedUrl = null;
                      isScanning = true;
                    });
                  },
                  child: Text(
                    "Scan Again",
                    style: TextStyle(fontSize: r.fontSmall()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
