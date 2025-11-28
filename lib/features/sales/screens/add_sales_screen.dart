import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/sales/database/add_sales_screen_database.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:bikretaa/features/sales/widgets/products_list_widget.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_address.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_name_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/utils/string_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/phone_utils.dart';

class AddSalesScreen extends StatefulWidget {
  const AddSalesScreen({super.key});

  @override
  State<AddSalesScreen> createState() => _AddSalesScreenState();
  static const name = '/Add_sales';
}

class _AddSalesScreenState extends State<AddSalesScreen> {
  final AddSalesScreenDatabase _salesService = AddSalesScreenDatabase();

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _mobileEcontroller = TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;
  List<Map<String, String>> _addedProducts = [];

  @override
  void initState() {
    super.initState();
    _paidController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "product_sales".tr,
          style: r.textStyle(fontSize: r.fontXL()),
        ),
        centerTitle: true,
      ),
      body: uid == null
          ? Center(child: Text("user_not_logged_in".tr))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: r.height(0.012),
                  horizontal: r.width(0.03),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: r.height(0.015)),
                      Container(
                        height: r.height(0.08),
                        child: CustomerNameController(
                          CustomerNameController: _customerNameController,
                        ),
                      ),
                      SizedBox(height: r.height(0.016)),
                      Container(
                        height: r.height(0.08),
                        child: MobileFeildWidget(
                          mobileEcontroller: _mobileEcontroller,
                        ),
                      ),
                      SizedBox(height: r.height(0.016)),
                      Container(
                        height: r.height(0.08),
                        child: CustomerAddressController(
                          CustomerAddressController: _customerAddressController,
                        ),
                      ),
                      SizedBox(height: r.height(0.016)),

                      // Products list
                      ProductsListWidget(
                        products: _addedProducts,
                        onRemoveProduct: (index) {
                          setState(() {
                            _addedProducts.removeAt(index);
                          });
                        },
                      ),
                      SizedBox(height: r.height(0.025)),

                      // Add Product Row
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _productIdController,
                              decoration: InputDecoration(
                                labelText: "product_id".tr,
                              ),
                            ),
                          ),
                          SizedBox(width: r.width(0.02)),
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "quantity".tr,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_box,
                              color: Colors.green,
                              size: r.iconLarge(),
                            ),
                            onPressed: () {
                              if (uid != null) _addProductToList(uid);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: r.height(0.025)),

                      // Paid & Due Row
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _paidController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "paid".tr,
                                labelStyle: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: r.width(0.02)),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(r.duefeildPadding()),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(
                                  r.radiusMedium(),
                                ),
                              ),
                              child: due < 0
                                  ? Text(
                                      "due_check".tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: r.fontMedium(),
                                      ),
                                    )
                                  : Text(
                                      "${'due'.tr}: ${due.toStringAsFixed(2)} tk",
                                      style: r.textStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(r.width(0.03)),
        child: Visibility(
          visible: !_loading,
          replacement: SizedBox(
            child: ElevatedButton(
              onPressed: null,
              child: CircularProgressIndicator(),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              final uid = FirebaseAuth.instance.currentUser?.uid;
              if (uid != null) _confirmSale(uid);
            },
            child: Text(
              "confirm".tr,
              style: r.textStyle(fontSize: r.fontMedium(), color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _addProductToList(String uid) async {
    if (!_formKey.currentState!.validate()) return;

    final productId = _productIdController.text.trim();
    final quantityText = _quantityController.text.trim();
    final product = await _salesService.fetchProductById(uid, productId);

    if (product != null) {
      final quantity = int.tryParse(quantityText) ?? 0;

      if (quantity <= 0) return;

      if (quantity > product.quantity) {
        showSnackbarMessage(
          context,
          "Out of stock! Only ${product.quantity} available.",
        );
        return;
      }

      final unitPrice = product.sellingPrice - product.discountPrice;
      final totalPrice = unitPrice * quantity;

      final newProduct = {
        'productId': product.productId,
        'productName': product.productName,
        'quantity': quantity.toString(),
        'unitPrice': unitPrice.toStringAsFixed(2),
        'totalPrice': totalPrice.toStringAsFixed(2),
      };

      setState(() {
        final existingIndex = _addedProducts.indexWhere(
          (item) => item['productId'] == product.productId,
        );

        if (existingIndex != -1) {
          _addedProducts[existingIndex] = newProduct;
        } else {
          _addedProducts.add(newProduct);
        }
      });

      _productIdController.clear();
      _quantityController.clear();
    } else {
      showSnackbarMessage(context, "product_not_found".tr);
    }
  }

  Future<void> _confirmSale(String uid) async {
    if (!_formKey.currentState!.validate()) return;

    final customerName = StringUtils.sanitize(
      _customerNameController.text.trim(),
    );

    // Use PhoneUtils to add +880 prefix safely
    final rawMobile = _mobileEcontroller.text.trim();
    final customerMobile = PhoneUtils.addBdPrefix(rawMobile);

    // Use StringUtils
    final customerAddress = StringUtils.sanitize(
      _customerAddressController.text.trim(),
    );

    final sale = SalesModel(
      grandTotal: grandTotal,
      paidAmount: double.tryParse(_paidController.text) ?? 0,
      dueAmount: due,
      products: _addedProducts,
      customerUID: '',
    );

    setState(() => _loading = true);

    try {
      await _salesService.saveSale(
        uid: uid,
        sale: sale,
        addedProducts: _addedProducts,
        customerName: customerName,
        customerMobile: customerMobile,
        customerAddress: customerAddress,
      );
      showSnackbarMessage(context, "sale_saved".tr);
      _resetForm();
    } catch (e) {
      showSnackbarMessage(context, e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  void _resetForm() {
    _addedProducts.clear();
    _productIdController.clear();
    _quantityController.clear();
    _paidController.clear();
    _customerNameController.clear();
    _mobileEcontroller.clear();
    _customerAddressController.clear();
  }

  double get grandTotal => _addedProducts.fold(
    0.0,
    (sum, item) => sum + (double.tryParse(item['totalPrice'] ?? "0") ?? 0),
  );

  double get due {
    final paid = double.tryParse(_paidController.text.trim()) ?? 0;
    return grandTotal - paid;
  }
}
