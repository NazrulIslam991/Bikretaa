import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/confirm_password_feild_widget.dart';
import 'package:bikretaa/ui/widgets/email_feild_controller.dart';
import 'package:bikretaa/ui/widgets/mobile_feild_widget.dart';
import 'package:bikretaa/ui/widgets/password_feild_widget.dart';
import 'package:bikretaa/ui/widgets/shop_name_widget.dart';
import 'package:bikretaa/ui/widgets/shop_type_dropdown_menu.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  TextEditingController _emailEcontroller = TextEditingController();
  TextEditingController _shopNameEcontroller = TextEditingController();
  TextEditingController _mobileEcontroller = TextEditingController();
  TextEditingController _passwordEcontroller = TextEditingController();
  TextEditingController _confirmpasswordEcontroller = TextEditingController();

  String? selectedShopType;

  bool _SignupInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background_image(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Shop Information",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    SizedBox(height: 20.h),

                    Container(
                      height: 65.h,
                      child: ShopNameWidget(
                        shopNameEcontroller: _shopNameEcontroller,
                      ),
                    ),

                    SizedBox(height: 5.h),
                    Container(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                        emailText: widget.email,
                      ),
                    ),

                    SizedBox(height: 5.h),
                    Container(
                      height: 65.h,
                      child: MobileFeildWidget(
                        mobileEcontroller: _mobileEcontroller,
                      ),
                    ),

                    ////SizedBox(height: 20.h),
                    Container(
                      height: 65.h,
                      child: ShopTypeDropdownWidget(
                        onSaved: (value) {
                          setState(() {
                            selectedShopType = value;
                          });
                        },
                      ),
                    ),

                    //SizedBox(height: 5.h),
                    Container(
                      height: 65.h,
                      child: PasswordFeildWidget(
                        passwordEcontroller: _passwordEcontroller,
                      ),
                    ),

                    SizedBox(height: 5.h),
                    Container(
                      height: 65.h,
                      child: ConfirmPasswordFeildWidget(
                        confirmpasswordEcontroller: _confirmpasswordEcontroller,
                        passwordEcontroller: _passwordEcontroller,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Visibility(
                      visible: !_SignupInProgress,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: SignUpComplete,
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.4,
                            fontSize: 10.h,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.h,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() => _onTapSignIn()),
                            ),
                          ],
                        ),
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

  //create account button section
  void SignUpComplete() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      signUpProcess();
    }
  }

  //"Database section for the sign-up process"
  Future<void> signUpProcess() async {
    final email = widget.email;
    final password = _passwordEcontroller.text.trim();
    final shopName = _shopNameEcontroller.text.trim();
    final phone = '+8801' + _mobileEcontroller.text.trim();
    final shopType = selectedShopType;

    setState(() {
      _SignupInProgress = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'Shop name': shopName,
        'Email': email,
        'Mobile': phone,
        'Shop Type': shopType,
        'createdAt': DateTime.now(),
      });
      showSnackbarMessage(context, "Sign Up Successful!");
      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninScreen.name,
        (predicate) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'weak-password':
          errorMessage =
              'Your password is too weak. Please use at least 6 characters.';
          break;
        case 'email-already-in-use':
          errorMessage = 'This email is already registered. Try signing in.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage =
              e.message ?? 'An unexpected error occurred. Please try again.';
      }

      showSnackbarMessage(context, errorMessage);
    } catch (e) {
      showSnackbarMessage(context, 'Something went wrong. Please try again.');
    } finally {
      setState(() {
        _SignupInProgress = false;
      });
    }
  }

  //sign in button section
  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }
}
