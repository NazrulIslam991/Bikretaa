import 'package:bikretaa/app/responsive.dart';
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
  final TextEditingController _paidController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool _loading = false;
  final List<Map<String, String>> _addedProducts = [];

  @override
  void initState() {
    super.initState();
    _paidController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "due_collection".tr,
          style: r.textStyle(fontSize: r.fontXL(), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: r.height(0.012),
            horizontal: r.width(0.04),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 75.h,
                  child: CustomerNameController(
                    CustomerNameController: _customerNameController,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: MobileFeildWidget(
                    mobileEcontroller: _mobileEcontroller,
                  ),
                ),
                SizedBox(
                  height: 75.h,
                  child: CustomerAddressController(
                    CustomerAddressController: _customerAddressController,
                  ),
                ),
                SizedBox(height: r.height(0.020)),

                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Search".tr,
                    style: r.textStyle(
                      fontSize: r.fontMedium(),
                      color: Colors.white,
                    ),
                  ),
                ),
                r.vSpace(0.025),

                // Products list
                ProductsListWidget(
                  products: _addedProducts,
                  onRemoveProduct: (index) {
                    setState(() {
                      _addedProducts.removeAt(index);
                    });
                  },
                ),
                SizedBox(height: r.height(0.020)),

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
                            fontSize: r.fontMedium(),
                          ),
                        ),
                      ),
                    ),
                    r.hSpace(0.02),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(r.width(0.048)),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(r.radiusMedium()),
                        ),
                        child: due < 0
                            ? Text(
                                "due_check".tr,
                                style: r.textStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              )
                            : Text(
                                "${'due'.tr}: ${due.toStringAsFixed(2)} tk",
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
        padding: EdgeInsets.all(r.paddingMedium()),
        child: Visibility(
          visible: !_loading,
          replacement: ElevatedButton(
            onPressed: null,
            child: CircularProgressIndicator(color: Colors.white),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "confirm".tr,
              style: r.textStyle(fontSize: r.fontMedium(), color: Colors.white),
            ),
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
}
