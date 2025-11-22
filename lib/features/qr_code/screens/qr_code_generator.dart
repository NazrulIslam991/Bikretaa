import 'dart:typed_data';

import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_brand_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_description_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_discount_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_expire_date_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_id_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_manufacture_date_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_name_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_purchase_price_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_quantity_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_selling_price_controller.dart';
import 'package:bikretaa/features/products/widgets/input_text_feild/product_supplier_name_controller.dart';
import 'package:bikretaa/features/qr_code/services/qr_code_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});
  static const name = '/qr_code_generator';

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  String? qrData;

  // Controllers
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _discountPriceController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _manufactureDateController =
      TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _brandNameController.dispose();
    _productIdController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _discountPriceController.dispose();
    _quantityController.dispose();
    _supplierNameController.dispose();
    _manufactureDateController.dispose();
    _expireDateController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }

  void _generateQRCode() {
    final Map<String, String> productInfo = {
      "Product Name": _productNameController.text,
      "Brand": _brandNameController.text,
      "Product ID": _productIdController.text,
      "Purchase Price": _purchasePriceController.text,
      "Selling Price": _sellingPriceController.text,
      "Discount": _discountPriceController.text,
      "Quantity": _quantityController.text,
      "Supplier Name": _supplierNameController.text,
      "Manufacture Date": _manufactureDateController.text,
      "Expire Date": _expireDateController.text,
      "Description": _productDescriptionController.text,
    };

    if (productInfo.values.any((v) => v.isEmpty)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      qrData = QRService.generateQRData(productInfo);
    });
  }

  Future<void> _downloadQRCode() async {
    if (qrData == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Generate QR code first")));
      return;
    }

    final Uint8List? imageBytes = await _screenshotController.capture();
    if (imageBytes == null) return;

    final success = await QRService.saveQRCode(imageBytes);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "QR Code saved to gallery" : "Failed to save QR Code",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QR Code Generator",
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 65.h,
              child: ProductNameController(
                ProductNameController: _productNameController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductBrandController(
                productBandNameController: _brandNameController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductIdController(
                productIdController: _productIdController,
                readOnly: false,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductPurchasePrice(
                ProductPurchasePrice: _purchasePriceController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductSellingPriceController(
                ProductSellingPriceController: _sellingPriceController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductDiscountController(
                productDiscountController: _discountPriceController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductQuantityController(
                productQuantityController: _quantityController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductSupplierNameController(
                productSupplierNameController: _supplierNameController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductManufactureDateController(
                productManufactureDateController: _manufactureDateController,
              ),
            ),
            SizedBox(
              height: 65.h,
              child: ProductExpireDateController(
                ProductExpireDateController: _expireDateController,
              ),
            ),
            ProductDescriptionController(
              productDescriptionController: _productDescriptionController,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateQRCode,
              child: const Text("Generate QR Code"),
            ),
            const SizedBox(height: 20),
            if (qrData != null)
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 200,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (qrData != null)
              ElevatedButton.icon(
                onPressed: _downloadQRCode,
                icon: const Icon(Icons.download),
                label: const Text("Download QR Code"),
              ),
          ],
        ),
      ),
    );
  }
}
