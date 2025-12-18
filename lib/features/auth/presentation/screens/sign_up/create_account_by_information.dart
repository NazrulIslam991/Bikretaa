import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/auth/presentation/widgets/auth_botto_text.dart';
import 'package:bikretaa/features/auth/presentation/widgets/shop_type_dropdown_menu.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/confirm_password_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/email_feild_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/mobile_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/password_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/shop_name_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccountByInformation extends StatefulWidget {
  final String email;
  const CreateAccountByInformation({super.key, required this.email});

  @override
  State<CreateAccountByInformation> createState() =>
      _CreateAccountByInformationState();
  static const name = 'Created_account_by_information';
}

class _CreateAccountByInformationState
    extends State<CreateAccountByInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEcontroller = TextEditingController();
  final TextEditingController _shopNameEcontroller = TextEditingController();
  final TextEditingController _mobileEcontroller = TextEditingController();
  final TextEditingController _passwordEcontroller = TextEditingController();
  final TextEditingController _confirmpasswordEcontroller =
      TextEditingController();

  String? selectedShopType;

  bool _signupInProgress = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: r.height(0.02),
                horizontal: r.width(0.04),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Shop_HeadLine'.tr,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: r.fontXXXL(),
                      ),
                    ),
                    SizedBox(height: r.height(0.02)),

                    SizedBox(
                      height: 75.h,
                      child: ShopNameWidget(
                        shopNameEcontroller: _shopNameEcontroller,
                      ),
                    ),

                    SizedBox(
                      height: 75.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                        emailText: widget.email,
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
                      child: ShopTypeDropdownWidget(
                        onSaved: (value) {
                          setState(() {
                            selectedShopType = value;
                          });
                        },
                      ),
                    ),

                    SizedBox(
                      height: 75.h,
                      child: PasswordFeildWidget(
                        passwordEcontroller: _passwordEcontroller,
                      ),
                    ),

                    SizedBox(
                      height: 75.h,
                      child: ConfirmPasswordFeildWidget(
                        confirmpasswordEcontroller: _confirmpasswordEcontroller,
                        passwordEcontroller: _passwordEcontroller,
                      ),
                    ),

                    SizedBox(height: r.height(0.02)),

                    Visibility(
                      visible: !_signupInProgress,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: signUpComplete,
                        child: Text(
                          'Done'.tr,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: r.fontMedium(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: r.height(0.02)),

                    Center(
                      child: AuthBottomText(
                        normalText: 'Sign_up_bottom_text_1'.tr,
                        actionText: 'Sign_up_bottom_text_2'.tr,
                        onTap: _onTapSignIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpComplete() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      signUpProcess();
    }
  }

  Future<void> signUpProcess() async {
    final email = widget.email;
    final password = _passwordEcontroller.text.trim();
    final shopName = _shopNameEcontroller.text.trim();
    final phone = '+8801${_mobileEcontroller.text.trim()}';
    final shopType = selectedShopType;

    setState(() {
      _signupInProgress = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;
      final userModel = UserModel(
        shopName: shopName,
        email: email,
        phone: phone,
        shopType: shopType,
        createdAt: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userModel.toMap());

      showSnackbarMessage(context, 'Sign_Up_Successful'.tr);
      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninScreen.name,
        (predicate) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Your_password_is_too_weak_Please_use_at.....'.tr;
          break;
        case 'email-already-in-use':
          errorMessage = 'This_email_is_already_registered'.tr;
          break;
        case 'invalid-email':
          errorMessage = 'The_email_address_is_not_valid'.tr;
          break;
        default:
          errorMessage =
              e.message ?? 'An unexpected error occurred. Please try again.';
      }
      showSnackbarMessage(context, errorMessage);
    } catch (e) {
      showSnackbarMessage(context, 'Something_went_wrong'.tr);
    } finally {
      setState(() {
        _signupInProgress = false;
      });
    }
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }
}
