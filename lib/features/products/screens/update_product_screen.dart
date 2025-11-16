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

class UpdateProductScreen extends StatefulWidget {
  final Product product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _productDatabase = ProductDatabase();

  late TextEditingController _productNameController;
  late TextEditingController _brandNameController;
  late TextEditingController _productIdController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _sellingPriceController;
  late TextEditingController _discountPriceController;
  late TextEditingController _quantityController;
  late TextEditingController _supplierNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _manufactureDateController;
  late TextEditingController _expireDateController;

  File? _selectedImage;
  String? _existingImageUrl;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductProgressIndicator = false;

  @override
  void initState() {
    super.initState();
    final product = widget.product;

    _productIdController = TextEditingController(text: product.productId);
    _productNameController = TextEditingController(text: product.productName);
    _brandNameController = TextEditingController(text: product.brandName);
    _purchasePriceController = TextEditingController(
      text: product.purchasePrice.toString(),
    );
    _sellingPriceController = TextEditingController(
      text: product.sellingPrice.toString(),
    );
    _discountPriceController = TextEditingController(
      text: product.discountPrice.toString(),
    );
    _quantityController = TextEditingController(
      text: product.quantity.toString(),
    );
    _supplierNameController = TextEditingController(text: product.supplierName);
    _descriptionController = TextEditingController(text: product.description);
    _manufactureDateController = TextEditingController(
      text: product.manufactureDate,
    );
    _expireDateController = TextEditingController(text: product.expireDate);
    _existingImageUrl = product.image;
  }

  @override
  void dispose() {
    _productIdController.dispose();
    _productNameController.dispose();
    _brandNameController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _discountPriceController.dispose();
    _quantityController.dispose();
    _supplierNameController.dispose();
    _descriptionController.dispose();
    _manufactureDateController.dispose();
    _expireDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "update_product".tr,
          style: r.textStyle(fontSize: r.fontXL()),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: r.paddingSmall(),
            horizontal: r.paddingMedium(),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                r.vSpace(0.01),
                Container(
                  height: 65.h,
                  child: ProductNameController(
                    ProductNameController: _productNameController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductBrandController(
                    productBandNameController: _brandNameController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductIdController(
                    productIdController: _productIdController,
                    readOnly: true,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductPurchasePrice(
                    ProductPurchasePrice: _purchasePriceController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductSellingPriceController(
                    ProductSellingPriceController: _sellingPriceController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductDiscountController(
                    productDiscountController: _discountPriceController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductQuantityController(
                    productQuantityController: _quantityController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductSupplierNameController(
                    productSupplierNameController: _supplierNameController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductManufactureDateController(
                    productManufactureDateController:
                        _manufactureDateController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductExpireDateController(
                    ProductExpireDateController: _expireDateController,
                  ),
                ),
                ProductDescriptionController(
                  productDescriptionController: _descriptionController,
                ),
                r.vSpace(0.02),
                // Image Picker
                CustomImagePicker(
                  height: r.height(0.20),
                  width: double.infinity,
                  onImageSelected: (File file) {
                    _selectedImage = file;
                  },
                ),
                r.vSpace(0.01),
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
          visible: !_updateProductProgressIndicator,
          replacement: CenterCircularProgressIndiacator(),
          child: ElevatedButton(
            onPressed: _onTapUpdateProduct,
            child: Text(
              "update_product_btn".tr,
              style: r.textStyle(fontSize: r.fontMedium()),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateProduct() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _updateProductProgressIndicator = true);

    String? imageUrl = _existingImageUrl;

    if (_selectedImage != null) {
      final uploadedUrl = await cloudinaryService.uploadImage(_selectedImage!);
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      } else {
        showSnackbarMessage(context, "Image upload failed!");
        setState(() => _updateProductProgressIndicator = false);
        return;
      }
    }

    final updatedProduct = Product(
      productId: _productIdController.text.trim(),
      productName: _productNameController.text.trim(),
      brandName: _brandNameController.text.trim(),
      purchasePrice: double.tryParse(_purchasePriceController.text.trim()) ?? 0,
      sellingPrice: double.tryParse(_sellingPriceController.text.trim()) ?? 0,
      discountPrice: double.tryParse(_discountPriceController.text.trim()) ?? 0,
      quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
      supplierName: _supplierNameController.text.trim(),
      description: _descriptionController.text.trim(),
      manufactureDate: _manufactureDateController.text.trim(),
      expireDate: _expireDateController.text.trim(),
      image: imageUrl ?? '',
      createdAt: DateTime.now(),
    );

    try {
      await _productDatabase.updateProduct(updatedProduct);
      showSnackbarMessage(context, "Product updated successfully");
      Navigator.pop(context);
    } catch (e) {
      showSnackbarMessage(context, "Error updating product: $e");
    } finally {
      setState(() => _updateProductProgressIndicator = false);
    }
  }
}
