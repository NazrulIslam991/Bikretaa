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

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
  static const name = 'Details_product';
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _brandNameController = TextEditingController();
  TextEditingController _PurchasePriceController = TextEditingController();
  TextEditingController _SellingPriceController = TextEditingController();
  TextEditingController _DiscountPriceController = TextEditingController();
  TextEditingController _QuantityController = TextEditingController();
  TextEditingController _SuppliarNameController = TextEditingController();
  TextEditingController _BarCodeNoController = TextEditingController();
  TextEditingController _ProductDescriptionController = TextEditingController();
  TextEditingController _ManufactureDateController = TextEditingController();
  TextEditingController _ExpireDateController = TextEditingController();
  String? selectedShopType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product", style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProductNameController(
                ProductNameController: _productNameController,
              ),
              SizedBox(height: 20),

              ProductBrandController(
                productBandNameController: _brandNameController,
              ),
              SizedBox(height: 20),

              ProductPurchasePrice(
                ProductPurchasePrice: _PurchasePriceController,
              ),
              SizedBox(height: 20),

              ProductSellingPriceController(
                ProductSellingPriceController: _SellingPriceController,
              ),
              SizedBox(height: 20),

              ProductDiscountController(
                productDiscountController: _DiscountPriceController,
              ),
              SizedBox(height: 20),

              ProductQuantityController(
                productQuantityController: _QuantityController,
              ),
              SizedBox(height: 20),

              ProductSupplierNameController(
                productSupplierNameController: _SuppliarNameController,
              ),
              SizedBox(height: 20),

              ProductBarCodeController(
                productBarCodeController: _BarCodeNoController,
              ),
              SizedBox(height: 20),

              ProductDescriptionController(
                productDescriptionController: _ProductDescriptionController,
              ),
              SizedBox(height: 20),
              ShopTypeDropdownWidget(
                onSaved: (value) {
                  selectedShopType = value;
                },
              ),
              SizedBox(height: 20),

              ProductManufactureDateController(
                productManufactureDateController: _ManufactureDateController,
              ),
              SizedBox(height: 20),

              ProductExpireDateController(
                ProductExpireDateController: _ExpireDateController,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 30, top: 10, right: 20, left: 20),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(onPressed: () {}, child: Text("Add Product")),
        ),
      ),
    );
  }
}
