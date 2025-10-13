import 'package:bikretaa/features/sales/database/add_sales_screen_database.dart';
import 'package:bikretaa/features/sales/database/update_screen_database.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:bikretaa/features/sales/widgets/products_list_widget.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_address.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_name_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        mobile = mobile.replaceFirst(RegExp(r'^\+880'), '');
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
        showSnackbarMessage(context, "Sale not found");
      }
    } catch (e) {
      setState(() => _fetching = false);
      showSnackbarMessage(context, "Failed to fetch sale: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final uid = _auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Sales", style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                CustomerNameController(
                  CustomerNameController: _customerNameController,
                ),
                SizedBox(height: 5.h),
                MobileFeildWidget(mobileEcontroller: _mobileEcontroller),
                SizedBox(height: 5.h),
                CustomerAddressController(
                  CustomerAddressController: _customerAddressController,
                ),
                SizedBox(height: 10.h),
                ProductsListWidget(
                  products: _addedProducts,
                  onRemoveProduct: (index) {
                    setState(() {
                      _addedProducts.removeAt(index);
                    });
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _productIdController,
                        decoration: const InputDecoration(
                          labelText: "Product ID",
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Quantity",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_box,
                        color: Colors.green,
                        size: 25.h,
                      ),
                      onPressed: () async {
                        if (uid != null) await _addProductToList(uid);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _paidController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Paid"),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: due < 0
                            ? const Text(
                                "Please check your paid amount!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              )
                            : Text(
                                "Due: ${due.toStringAsFixed(2)} tk",
                                style: const TextStyle(
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
        padding: EdgeInsets.all(12.h),
        child: ElevatedButton(
          onPressed: (_loading || uid == null) ? null : _confirmUpdate,
          child: _loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text("Update Sale", style: TextStyle(fontSize: 16.sp)),
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
      showSnackbarMessage(context, "Product not found");
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

      showSnackbarMessage(context, "Sale updated successfully!");
      Navigator.pop(context);
    } catch (e) {
      showSnackbarMessage(context, "Failed to update sale: $e");
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
