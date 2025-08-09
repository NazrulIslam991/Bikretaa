import 'package:bikretaa/ui/widgets/product_controller_feild/product_barcode_no_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_brand_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_description_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_discount_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_expire_date_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_manufacture_date_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_name_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_purchase_price_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_quantity_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_selling_price_controller.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/product_supplier_name_controller.dart';
import 'package:bikretaa/ui/widgets/shop_type_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
  static const name = 'Details_product';
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _PurchasePriceController =
      TextEditingController();
  final TextEditingController _SellingPriceController = TextEditingController();
  final TextEditingController _DiscountPriceController =
      TextEditingController();
  final TextEditingController _QuantityController = TextEditingController();
  final TextEditingController _SuppliarNameController = TextEditingController();
  final TextEditingController _BarCodeNoController = TextEditingController();
  final TextEditingController _ProductDescriptionController =
      TextEditingController();
  final TextEditingController _ManufactureDateController =
      TextEditingController();
  final TextEditingController _ExpireDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedShopType;

  @override
  void dispose() {
    _productNameController.dispose();
    _brandNameController.dispose();
    _PurchasePriceController.dispose();
    _SellingPriceController.dispose();
    _DiscountPriceController.dispose();
    _QuantityController.dispose();
    _SuppliarNameController.dispose();
    _BarCodeNoController.dispose();
    _ProductDescriptionController.dispose();
    _ManufactureDateController.dispose();
    _ExpireDateController.dispose();
    super.dispose();
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
                Container(
                  height: 65.h,
                  child: ProductNameController(
                    ProductNameController: _productNameController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductBrandController(
                    productBandNameController: _brandNameController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductPurchasePrice(
                    ProductPurchasePrice: _PurchasePriceController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductSellingPriceController(
                    ProductSellingPriceController: _SellingPriceController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductDiscountController(
                    productDiscountController: _DiscountPriceController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductQuantityController(
                    productQuantityController: _QuantityController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductSupplierNameController(
                    productSupplierNameController: _SuppliarNameController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductBarCodeController(
                    productBarCodeController: _BarCodeNoController,
                  ),
                ),

                //SizedBox(height: 5.h),
                ProductDescriptionController(
                  productDescriptionController: _ProductDescriptionController,
                ),

                SizedBox(height: 15.h),
                ShopTypeDropdownWidget(
                  onSaved: (value) {
                    selectedShopType = value;
                  },
                ),
                SizedBox(height: 20.h),

                Container(
                  height: 65.h,
                  child: ProductManufactureDateController(
                    productManufactureDateController:
                        _ManufactureDateController,
                  ),
                ),

                //SizedBox(height: 5.h),
                Container(
                  height: 65.h,
                  child: ProductExpireDateController(
                    ProductExpireDateController: _ExpireDateController,
                  ),
                ),
                //SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15, top: 0, right: 16, left: 16),
        child: Container(
          height: 40.h,
          child: ElevatedButton(
            onPressed: _onTapAddProduct,
            child: Text("Add Product"),
          ),
        ),
      ),
    );
  }

  void _onTapAddProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final productName = _productNameController.text.trim();
      final brandName = _brandNameController.text.trim();
      final purchasePrice =
          double.tryParse(_PurchasePriceController.text.trim()) ?? 0;
      final sellingPrice =
          double.tryParse(_SellingPriceController.text.trim()) ?? 0;
      final discountPrice =
          double.tryParse(_DiscountPriceController.text.trim()) ?? 0;
      final quantity = int.tryParse(_QuantityController.text.trim()) ?? 0;
      final supplierName = _SuppliarNameController.text.trim();
      final barcodeNo = _BarCodeNoController.text.trim();
      final description = _ProductDescriptionController.text.trim();
      final manufactureDate = _ManufactureDateController.text.trim();
      final expireDate = _ExpireDateController.text.trim();

      final productData = {
        'productName': productName,
        'brandName': brandName,
        'purchasePrice': purchasePrice,
        'sellingPrice': sellingPrice,
        'discountPrice': discountPrice,
        'quantity': quantity,
        'supplierName': supplierName,
        'barcodeNo': barcodeNo,
        'description': description,
        'manufactureDate': manufactureDate,
        'expireDate': expireDate,
        'shopType': selectedShopType ?? '',
        'createdAt': DateTime.now().toIso8601String(),
      };

      print(productData);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Product added successfully!')));

      _formKey.currentState!.reset();
      _productNameController.clear();
      _brandNameController.clear();
      _PurchasePriceController.clear();
      _SellingPriceController.clear();
      _DiscountPriceController.clear();
      _QuantityController.clear();
      _SuppliarNameController.clear();
      _BarCodeNoController.clear();
      _ProductDescriptionController.clear();
      _ManufactureDateController.clear();
      _ExpireDateController.clear();

      setState(() {
        selectedShopType = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all required fields properly',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w700,
              fontSize: 10.h,
            ),
          ),
        ),
      );
    }
  }
}
