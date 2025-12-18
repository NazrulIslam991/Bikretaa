import 'dart:io';

import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/products/database/product_database.dart';
import 'package:bikretaa/features/products/model/product_model.dart';
import 'package:bikretaa/features/products/widgets/image_picker/custom_image_picker.dart';
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
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const name = 'Add_product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _addProductDatabase = ProductDatabase();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _discountPriceController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _suppliarNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _manufactureDateController =
      TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();

  File? _selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addProductProgressIndicator = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _brandNameController.dispose();
    _productIdController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _discountPriceController.dispose();
    _quantityController.dispose();
    _suppliarNameController.dispose();
    _productDescriptionController.dispose();
    _manufactureDateController.dispose();
    _expireDateController.dispose();
    super.dispose();
  }

  void _clearControllers() {
    _productNameController.clear();
    _brandNameController.clear();
    _productIdController.clear();
    _purchasePriceController.clear();
    _sellingPriceController.clear();
    _discountPriceController.clear();
    _quantityController.clear();
    _suppliarNameController.clear();
    _productDescriptionController.clear();
    _manufactureDateController.clear();
    _expireDateController.clear();
    _selectedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "add_product_title".tr,
          style: TextStyle(fontSize: r.fontXL()),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: r.width(0.02),
            right: r.width(0.02),
            top: r.height(0.01),
            bottom: r.height(0.01),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: r.height(0.01)),

                SizedBox(
                  height: 75.h,
                  child: ProductNameController(
                    ProductNameController: _productNameController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductBrandController(
                    productBandNameController: _brandNameController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductIdController(
                    productIdController: _productIdController,
                    readOnly: false,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductPurchasePrice(
                    ProductPurchasePrice: _purchasePriceController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductSellingPriceController(
                    ProductSellingPriceController: _sellingPriceController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductDiscountController(
                    productDiscountController: _discountPriceController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductQuantityController(
                    productQuantityController: _quantityController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductSupplierNameController(
                    productSupplierNameController: _suppliarNameController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductManufactureDateController(
                    productManufactureDateController:
                        _manufactureDateController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: ProductExpireDateController(
                    ProductExpireDateController: _expireDateController,
                  ),
                ),
                ProductDescriptionController(
                  productDescriptionController: _productDescriptionController,
                ),
                SizedBox(height: r.height(0.03)),

                // Image Picker
                CustomImagePicker(
                  height: r.height(0.2),
                  width: double.infinity,
                  onImageSelected: (File file) => _selectedImage = file,
                ),

                SizedBox(height: r.height(0.01)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: r.height(0.02),
          left: r.width(0.04),
          right: r.width(0.04),
          top: r.height(0.01),
        ),
        child: Visibility(
          visible: !_addProductProgressIndicator,
          replacement: CenterCircularProgressIndiacator(),
          child: ElevatedButton(
            onPressed: _onTapAddProduct,
            child: Text(
              "add_product_btn".tr,
              style: TextStyle(fontSize: r.fontMedium()),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddProduct() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_selectedImage == null) {
      showSnackbarMessage(context, "select_product_image".tr);
      return;
    }

    setState(() => _addProductProgressIndicator = true);

    try {
      final imageUrl = await cloudinaryService.uploadImage(_selectedImage!);
      if (imageUrl == null) {
        showSnackbarMessage(context, "image_upload_failed".tr);
        setState(() => _addProductProgressIndicator = false);
        return;
      }

      final product = Product(
        productId: _productIdController.text.trim(),
        productName: _productNameController.text.trim(),
        brandName: _brandNameController.text.trim(),
        purchasePrice:
            double.tryParse(_purchasePriceController.text.trim()) ?? 0,
        sellingPrice: double.tryParse(_sellingPriceController.text.trim()) ?? 0,
        discountPrice:
            double.tryParse(_discountPriceController.text.trim()) ?? 0,
        quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
        supplierName: _suppliarNameController.text.trim(),
        description: _productDescriptionController.text.trim(),
        manufactureDate: _manufactureDateController.text.trim(),
        expireDate: _expireDateController.text.trim(),
        image: imageUrl,
        createdAt: DateTime.now(),
      );

      final added = await _addProductDatabase.addProduct(product);
      if (added) {
        showSnackbarMessage(context, "product_added_success".tr);
        _clearControllers();
        Navigator.pop(context);
      } else {
        showSnackbarMessage(context, "product_id_exists".tr);
      }
    } catch (e) {
      showSnackbarMessage(context, "error_adding_product".tr);
    } finally {
      setState(() => _addProductProgressIndicator = false);
    }
  }
}
