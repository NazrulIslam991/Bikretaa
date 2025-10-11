import 'package:bikretaa/features/sales/database/add_sales_screen_database.dart';
import 'package:bikretaa/features/sales/model/SalesModel.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_address.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_name_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSalesScreen extends StatefulWidget {
  const AddSalesScreen({super.key});

  @override
  State<AddSalesScreen> createState() => _AddSalesScreenState();
  static const name = 'Add_sales';
}

class _AddSalesScreenState extends State<AddSalesScreen> {
  final AddSalesScreen_database _salesService = AddSalesScreen_database();

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
    _paidController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product sales", style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: uid == null
          ? Center(child: Text("User not logged in"))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        height: 65.h,
                        child: CustomerNameController(
                          CustomerNameController: _customerNameController,
                        ),
                      ),
                      Container(
                        height: 65.h,
                        child: MobileFeildWidget(
                          mobileEcontroller: _mobileEcontroller,
                        ),
                      ),
                      Container(
                        height: 65.h,
                        child: CustomerAddressController(
                          CustomerAddressController: _customerAddressController,
                        ),
                      ),

                      // Products list
                      _buildProductsList(),

                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _productIdController,
                              decoration: InputDecoration(
                                labelText: "Product ID",
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
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
                            onPressed: () {
                              if (uid != null) _addProductToList(uid);
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
                              decoration: InputDecoration(
                                labelText: "Paid",
                                labelStyle: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
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
                                  ? Text(
                                      "Please check your paid amount!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    )
                                  : Text(
                                      "Due: ${due.toStringAsFixed(2)} tk",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onSurface,
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
            child: Text("Confirm", style: TextStyle(fontSize: 16.sp)),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    return Container(
      height: 230.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: _addedProducts.isEmpty
          ? Center(child: Text("No products added"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _addedProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(index);
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text(
                    "Grand Total: ${grandTotal.toStringAsFixed(2)} tk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProductCard(int index) {
    final item = _addedProducts[index];

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey.shade50,
          child: Text(
            item['quantity'] ?? "0",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        title: Text(
          item['productName'] ?? "",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        subtitle: Text(
          "Unit: ${item['unitPrice']} tk\nTotal: ${item['totalPrice']} tk",
          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            setState(() {
              _addedProducts.removeAt(index);
            });
          },
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Out of stock! Only ${product.quantity} available."),
          ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product not found")));
    }
  }

  Future<void> _confirmSale(String uid) async {
    if (!_formKey.currentState!.validate()) return;

    final sale = SalesModel(
      customerName: _customerNameController.text.trim(),
      customerMobile: '+8801' + _mobileEcontroller.text.trim(),
      customerAddress: _customerAddressController.text.trim(),
      grandTotal: grandTotal,
      paidAmount: double.tryParse(_paidController.text) ?? 0,
      dueAmount: due,
      products: _addedProducts,
    );

    setState(() => _loading = true);

    try {
      await _salesService.saveSale(
        uid: uid,
        sale: sale,
        addedProducts: _addedProducts,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sale saved successfully!")));
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
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
