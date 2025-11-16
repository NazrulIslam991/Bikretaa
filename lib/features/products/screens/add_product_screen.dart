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
  final TextEditingController _PurchasePriceController =
      TextEditingController();
  final TextEditingController _SellingPriceController = TextEditingController();
  final TextEditingController _DiscountPriceController =
      TextEditingController();
  final TextEditingController _QuantityController = TextEditingController();
  final TextEditingController _SuppliarNameController = TextEditingController();
  final TextEditingController _ProductDescriptionController =
      TextEditingController();
  final TextEditingController _ManufactureDateController =
      TextEditingController();
  final TextEditingController _ExpireDateController = TextEditingController();

  File? _selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addProductProgressIndicator = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _brandNameController.dispose();
    _productIdController.dispose();
    _PurchasePriceController.dispose();
    _SellingPriceController.dispose();
    _DiscountPriceController.dispose();
    _QuantityController.dispose();
    _SuppliarNameController.dispose();
    _ProductDescriptionController.dispose();
    _ManufactureDateController.dispose();
    _ExpireDateController.dispose();
    super.dispose();
  }

  void _clearControllers() {
    _productNameController.clear();
    _brandNameController.clear();
    _productIdController.clear();
    _PurchasePriceController.clear();
    _SellingPriceController.clear();
    _DiscountPriceController.clear();
    _QuantityController.clear();
    _SuppliarNameController.clear();
    _ProductDescriptionController.clear();
    _ManufactureDateController.clear();
    _ExpireDateController.clear();
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
          padding: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 2),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: r.height(0.01)),

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
                    ProductPurchasePrice: _PurchasePriceController,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                  child: ProductSellingPriceController(
                    ProductSellingPriceController: _SellingPriceController,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                  child: ProductDiscountController(
                    productDiscountController: _DiscountPriceController,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                  child: ProductQuantityController(
                    productQuantityController: _QuantityController,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                  child: ProductSupplierNameController(
                    productSupplierNameController: _SuppliarNameController,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                  child: ProductManufactureDateController(
                    productManufactureDateController:
                        _ManufactureDateController,
                  ),
                ),
                SizedBox(
                  height: 65.h,
                  child: ProductExpireDateController(
                    ProductExpireDateController: _ExpireDateController,
                  ),
                ),
                ProductDescriptionController(
                  productDescriptionController: _ProductDescriptionController,
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
            double.tryParse(_PurchasePriceController.text.trim()) ?? 0,
        sellingPrice: double.tryParse(_SellingPriceController.text.trim()) ?? 0,
        discountPrice:
            double.tryParse(_DiscountPriceController.text.trim()) ?? 0,
        quantity: int.tryParse(_QuantityController.text.trim()) ?? 0,
        supplierName: _SuppliarNameController.text.trim(),
        description: _ProductDescriptionController.text.trim(),
        manufactureDate: _ManufactureDateController.text.trim(),
        expireDate: _ExpireDateController.text.trim(),
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
