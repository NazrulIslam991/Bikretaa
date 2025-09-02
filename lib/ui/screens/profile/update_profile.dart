import 'package:bikretaa/app/shared_preferences_helper.dart';
import 'package:bikretaa/models/user/user_model.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/ui/widgets/drop_down_menu/shop_type_dropdown_menu.dart';
import 'package:bikretaa/ui/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/ui/widgets/text_feild/mobile_feild_widget.dart';
import 'package:bikretaa/ui/widgets/text_feild/shop_name_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile', style: TextStyle(fontSize: 24.sp)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 65.h,
                  child: ShopNameWidget(
                    shopNameEcontroller: _shopNameEcontroller,
                  ),
                ),
                Container(
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.primary),
                    borderRadius: BorderRadius.circular(8.r),
                    color: theme.colorScheme.onPrimary,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          _emailEcontroller.text,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Container(
                  height: 65.h,
                  child: MobileFeildWidget(
                    mobileEcontroller: _mobileEcontroller,
                  ),
                ),
                ShopTypeDropdownWidget(
                  initialValue: selectedShopType,
                  onSaved: (value) => setState(() => selectedShopType = value),
                ),
                SizedBox(height: 20.h),
                FilledButton(
                  onPressed: _updateProfile,
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // load information from SharedPreferencesHelper
  Future<void> _loadUserData() async {
    UserModel? user = await SharedPreferencesHelper.getUser();
    if (user != null) {
      _emailEcontroller.text = user.email;
      _shopNameEcontroller.text = user.shopName;

      if (user.phone.startsWith("+8801")) {
        _mobileEcontroller.text = user.phone.substring(5);
      } else {
        _mobileEcontroller.text = user.phone;
      }

      selectedShopType = user.shopType;
      setState(() {});
    }
  }

  // update user information
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
      showSnackbarMessage(context, "Error: User data not found");
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
        showSnackbarMessage(context, "Profile updated successfully!");
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      showSnackbarMessage(context, "Error updating profile: $e");
    }
  }
}
