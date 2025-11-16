import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/sales/database/add_sales_screen_database.dart';
import 'package:bikretaa/features/sales/database/update_screen_database.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:bikretaa/features/sales/widgets/products_list_widget.dart';
import 'package:bikretaa/features/sales/widgets/sale_screen_shimmer/update_sales_screen_shimmer.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_address.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_name_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateSalesScreen extends StatefulWidget {
  final String salesID;

  const UpdateSalesScreen({Key? key, required this.salesID}) : super(key: key);

  @override
  State<UpdateSalesScreen> createState() => _UpdateSalesScreenState();
}

class _UpdateSalesScreenState extends State<UpdateSalesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AddSalesScreen_database _salesService = AddSalesScreen_database();
  final UpdateSalesDatabase _updateService = UpdateSalesDatabase();

  late TextEditingController _customerNameController;
  late TextEditingController _mobileEcontroller;
  late TextEditingController _customerAddressController;
  late TextEditingController _paidController;
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _fetching = true;

  List<Map<String, String>> _addedProducts = [];
  List<Map<String, String>> _oldProducts = [];

  @override
  void initState() {
    super.initState();
    _customerNameController = TextEditingController();
    _mobileEcontroller = TextEditingController();
    _customerAddressController = TextEditingController();
    _paidController = TextEditingController();

    _paidController.addListener(() => setState(() {}));
    _loadAndFetchSale();
  }

  Future<void> _loadAndFetchSale() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final data = await _updateService.fetchSale(uid, widget.salesID);
      if (data != null) {
        String mobile = data['customerMobile'] ?? '';
        mobile = mobile.replaceFirst(RegExp(r'^\+8801'), '');
        _mobileEcontroller.text = mobile;

        _customerNameController.text = data['customerName'] ?? '';
        _customerAddressController.text = data['customerAddress'] ?? '';
        _paidController.text =
            (data['paidAmount'] as num?)?.toStringAsFixed(2) ?? '0.0';

        final products = List<Map<String, String>>.from(
          (data['products'] ?? []).map((e) => Map<String, String>.from(e)),
        );

        setState(() {
          _addedProducts = products;
          _oldProducts = List<Map<String, String>>.from(products);
          _fetching = false;
        });
      } else {
        setState(() => _fetching = false);
        showSnackbarMessage(context, "sale_not_found".tr);
      }
    } catch (e) {
      setState(() => _fetching = false);
      showSnackbarMessage(context, "Failed to fetch sale: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    if (_fetching) return const Scaffold(body: UpdateSalesShimmerScreen());

    final uid = _auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "update_sale".tr,
          style: r.textStyle(fontSize: r.fontXXL()),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                ProductsListWidget(
                  products: _addedProducts,
                  onRemoveProduct: (index) {
                    setState(() {
                      _addedProducts.removeAt(index);
                    });
                  },
                ),
                SizedBox(height: r.height(0.025)),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _productIdController,
                        decoration: InputDecoration(labelText: "product_id".tr),
                      ),
                    ),
                    SizedBox(width: r.width(0.02)),
                    Expanded(
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "quantity".tr),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_box,
                        color: Colors.green,
                        size: r.iconLarge(),
                      ),
                      onPressed: () async {
                        if (uid != null) await _addProductToList(uid);
                      },
                    ),
                  ],
                ),
                SizedBox(height: r.height(0.025)),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _paidController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "paid".tr),
                      ),
                    ),
                    SizedBox(width: r.width(0.02)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(r.duefeildPadding()),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(r.radiusMedium()),
                        ),
                        child: due < 0
                            ? Text(
                                "check_paid_amount".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: r.fontMedium(),
                                ),
                              )
                            : Text(
                                "${"due".tr}: ${due.toStringAsFixed(2)} tk",
                                style: r.textStyle(fontWeight: FontWeight.bold),
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
        child: ElevatedButton(
          onPressed: (_loading || uid == null) ? null : _confirmUpdate,
          child: _loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  "update_sale_btn".tr,
                  style: r.textStyle(
                    fontSize: r.fontMedium(),
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _addProductToList(String uid) async {
    final productId = _productIdController.text.trim();
    final quantityText = _quantityController.text.trim();

    final product = await _salesService.fetchProductById(uid, productId);
    if (product != null) {
      final quantity = int.tryParse(quantityText) ?? 0;
      if (quantity <= 0) return;

      if (quantity > product.quantity) {
        showSnackbarMessage(
          context,
          "Out of stock! Only ${product.quantity} available",
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

  Future<void> _confirmUpdate() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    setState(() => _loading = true);

    final updatedSale = SalesModel(
      customerName: _customerNameController.text.trim(),
      customerMobile: '+880' + _mobileEcontroller.text.trim(),
      customerAddress: _customerAddressController.text.trim(),
      grandTotal: grandTotal,
      paidAmount: double.tryParse(_paidController.text.trim()) ?? 0,
      dueAmount: due,
      products: _addedProducts,
    );

    try {
      await _updateService.updateSale(
        uid: uid,
        salesID: widget.salesID,
        updatedSale: updatedSale,
        oldProducts: _oldProducts,
        newProducts: _addedProducts,
      );

      showSnackbarMessage(context, "sale_updated_success".tr);
      Navigator.pop(context);
    } catch (e) {
      showSnackbarMessage(context, "failed_update_sale".tr);
    } finally {
      setState(() => _loading = false);
    }
  }

  double get grandTotal => _addedProducts.fold<double>(
    0,
    (sum, item) => sum + (double.tryParse(item['totalPrice'] ?? "0") ?? 0),
  );

  double get paidAmount => double.tryParse(_paidController.text.trim()) ?? 0;

  double get due => grandTotal - paidAmount;
}
