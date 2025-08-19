import 'package:bikretaa/database/product_database.dart';
import 'package:bikretaa/models/product_model.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_brand_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_description_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_discount_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_expire_date_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_id_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_manufacture_date_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_name_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_purchase_price_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_quantity_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_selling_price_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_supplier_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProductScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final String brandName;
  final double purchasePrice;
  final double sellingPrice;
  final double discountPrice;
  final int quantity;
  final String supplierName;
  final String description;
  final String manufactureDate;
  final String expireDate;

  const UpdateProductScreen({
    super.key,
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.discountPrice,
    required this.quantity,
    required this.supplierName,
    required this.description,
    required this.manufactureDate,
    required this.expireDate,
  });

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _UpdateProductDatabase = ProductDatabase();

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
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _manufactureDateController =
      TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductProgressIndicator = false;

  @override
  void initState() {
    super.initState();
    // prefill form with product data
    _productIdController.text = widget.productId;
    _productNameController.text = widget.productName;
    _brandNameController.text = widget.brandName;
    _purchasePriceController.text = widget.purchasePrice.toString();
    _sellingPriceController.text = widget.sellingPrice.toString();
    _discountPriceController.text = widget.discountPrice.toString();
    _quantityController.text = widget.quantity.toString();
    _supplierNameController.text = widget.supplierName;
    _descriptionController.text = widget.description;
    _manufactureDateController.text = widget.manufactureDate;
    _expireDateController.text = widget.expireDate;
  }

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
    _descriptionController.dispose();
    _manufactureDateController.dispose();
    _expireDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product", style: TextStyle(fontSize: 22.h)),
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
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15, top: 0, right: 16, left: 16),
        child: Container(
          height: 40.h,
          child: Visibility(
            visible: !_updateProductProgressIndicator,
            replacement: CenterCircularProgressIndiacator(),
            child: ElevatedButton(
              onPressed: _onTapUpdateProduct,
              child: Text("Update Product"),
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
      createdAt: DateTime.now(),
    );

    try {
      await _UpdateProductDatabase.updateProduct(updatedProduct);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product updated successfully")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error updating product: $e")));
    } finally {
      setState(() => _updateProductProgressIndicator = false);
    }
  }
}
