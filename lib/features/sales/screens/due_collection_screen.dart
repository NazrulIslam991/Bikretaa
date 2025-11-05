import 'package:bikretaa/features/sales/widgets/products_list_widget.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_address.dart';
import 'package:bikretaa/features/sales/widgets/text_input_feild/customer_name_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DueCollectionScreen extends StatefulWidget {
  const DueCollectionScreen({super.key});

  @override
  State<DueCollectionScreen> createState() => _DueCollectionScreenState();
  static const name = '/DueCollectionScreen';
}

class _DueCollectionScreenState extends State<DueCollectionScreen> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _mobileEcontroller = TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  //final TextEditingController _productIdController = TextEditingController();
  //final TextEditingController _quantityController = TextEditingController();
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

    return Scaffold(
      appBar: AppBar(
        title: Text("due_collection".tr, style: TextStyle(fontSize: 22.sp)),
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

                ElevatedButton(onPressed: () {}, child: Text("Search".tr)),
                SizedBox(height: 20.h),

                // Products list
                ProductsListWidget(
                  products: _addedProducts,
                  onRemoveProduct: (index) {
                    setState(() {
                      _addedProducts.removeAt(index);
                    });
                  },
                ),
                SizedBox(height: 20.h),

                // Paid & Due
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
                                "due_check".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              )
                            : Text(
                                "${'due'.tr}: ${due.toStringAsFixed(2)} tk",
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
          replacement: ElevatedButton(
            onPressed: null,
            child: CircularProgressIndicator(color: Colors.white),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Text("confirm".tr, style: TextStyle(fontSize: 16.sp)),
          ),
        ),
      ),
    );
  }

  double get grandTotal => _addedProducts.fold(
    0.0,
    (sum, item) => sum + (double.tryParse(item['totalPrice'] ?? "0") ?? 0),
  );

  double get due {
    final paid = double.tryParse(_paidController.text.trim()) ?? 0;
    return grandTotal - paid;
  }

  // void _resetForm() {
  //   _addedProducts.clear();
  //   _productIdController.clear();
  //   _quantityController.clear();
  //   _paidController.clear();
  //   _customerNameController.clear();
  //   _mobileEcontroller.clear();
  //   _customerAddressController.clear();
  // }
}
