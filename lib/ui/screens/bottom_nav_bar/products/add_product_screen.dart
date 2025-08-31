import 'dart:io';

import 'package:bikretaa/database/product/product_database.dart';
import 'package:bikretaa/main.dart';
import 'package:bikretaa/models/product/product_model.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/image_picker/custom_image_picker.dart';
import 'package:bikretaa/ui/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_brand_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_description_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_discount_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_expire_date_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_id_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_manufacture_date_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_name_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_purchase_price_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_quantity_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_selling_price_controller.dart';
import 'package:bikretaa/ui/widgets/text_feild/product_supplier_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product", style: TextStyle(fontSize: 22.h)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
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
                    readOnly: false,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductPurchasePrice(
                    ProductPurchasePrice: _PurchasePriceController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductSellingPriceController(
                    ProductSellingPriceController: _SellingPriceController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductDiscountController(
                    productDiscountController: _DiscountPriceController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductQuantityController(
                    productQuantityController: _QuantityController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductSupplierNameController(
                    productSupplierNameController: _SuppliarNameController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductManufactureDateController(
                    productManufactureDateController:
                        _ManufactureDateController,
                  ),
                ),
                Container(
                  height: 65.h,
                  child: ProductExpireDateController(
                    ProductExpireDateController: _ExpireDateController,
                  ),
                ),
                ProductDescriptionController(
                  productDescriptionController: _ProductDescriptionController,
                ),
                SizedBox(height: 15.h),

                // Image Picker
                CustomImagePicker(
                  height: 150.h,
                  width: double.infinity,
                  onImageSelected: (File file) {
                    _selectedImage = file;
                  },
                ),

                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15, left: 16, right: 16),
        child: Container(
          height: 40.h,
          child: Visibility(
            visible: !_addProductProgressIndicator,
            replacement: CenterCircularProgressIndiacator(),
            child: ElevatedButton(
              onPressed: _onTapAddProduct,
              child: Text("Add Product"),
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
      showSnackbarMessage(context, "Please select a product image!");
      return;
    }

    setState(() => _addProductProgressIndicator = true);

    try {
      final imageUrl = await cloudinaryService.uploadImage(_selectedImage!);
      if (imageUrl == null) {
        showSnackbarMessage(context, "Image upload failed!");
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
        showSnackbarMessage(context, 'Product added successfully!');
        _clearControllers();
        Navigator.pop(context);
      } else {
        showSnackbarMessage(context, 'Product ID already exists!');
      }
    } catch (e) {
      showSnackbarMessage(context, 'Error adding product: $e');
    } finally {
      setState(() => _addProductProgressIndicator = false);
    }
  }
}
