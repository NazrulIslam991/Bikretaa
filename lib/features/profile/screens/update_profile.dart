import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:bikretaa/features/auth/presentation/widgets/shop_type_dropdown_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import '../../shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import '../../shared/presentation/widgets/auth_user_input_feild/shop_name_widget.dart';
import '../../shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import '../../shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEcontroller = TextEditingController();
  final TextEditingController _shopNameEcontroller = TextEditingController();
  final TextEditingController _mobileEcontroller = TextEditingController();
  String? selectedShopType;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: r.height(0.055),
        title: Text(
          'update_profile'.tr,
          style: TextStyle(fontSize: r.fontXL()),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: r.height(0.02),
          horizontal: r.width(0.04),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 75.h,
                child: ShopNameWidget(
                  shopNameEcontroller: _shopNameEcontroller,
                ),
              ),
              Container(
                height: r.height(0.065),
                padding: EdgeInsets.symmetric(horizontal: r.width(0.03)),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                  color: theme.colorScheme.onPrimary,
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.email, color: Colors.blue, size: r.fontLarge()),
                    SizedBox(width: r.width(0.02)),
                    Expanded(
                      child: Text(
                        _emailEcontroller.text,
                        style: TextStyle(
                          fontSize: r.fontSmall(),
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r.height(0.06)),
              SizedBox(
                height: 75.h,
                child: MobileFeildWidget(mobileEcontroller: _mobileEcontroller),
              ),

              ShopTypeDropdownWidget(
                initialValue: selectedShopType,
                onSaved: (value) => setState(() => selectedShopType = value),
              ),
              SizedBox(height: r.height(0.05)),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text(
                  'update_profile_btn'.tr,
                  style: TextStyle(
                    fontSize: r.fontSmall(),
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadUserData() async {
    UserModel? user = await SharedPreferencesHelper.getUser();
    if (user != null) {
      _emailEcontroller.text = user.email;
      _shopNameEcontroller.text = user.shopName;
      _mobileEcontroller.text = user.phone.startsWith("+8801")
          ? user.phone.substring(5)
          : user.phone;
      selectedShopType = user.shopType;
      setState(() {});
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CircularProgressIndicator2(),
    );

    UserModel? existingUser = await SharedPreferencesHelper.getUser();
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (existingUser == null || firebaseUser == null) {
      if (mounted) Navigator.pop(context);
      showSnackbarMessage(context, 'user_data_not_found'.tr);
      return;
    }

    String phoneToStore = _mobileEcontroller.text.trim();
    if (!phoneToStore.startsWith("+8801")) {
      phoneToStore = "+8801$phoneToStore";
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .update({
            'shopName': _shopNameEcontroller.text.trim(),
            'phone': phoneToStore,
            'shopType': selectedShopType,
          });

      UserModel updatedUser = UserModel(
        shopName: _shopNameEcontroller.text.trim(),
        email: existingUser.email,
        phone: phoneToStore,
        shopType: selectedShopType,
        createdAt: existingUser.createdAt,
      );
      await SharedPreferencesHelper.saveUser(updatedUser);

      if (mounted) {
        showSnackbarMessage(context, 'profile_updated_success'.tr);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      showSnackbarMessage(context, '${'error_updating_profile'.tr}: $e');
    }
  }
}
