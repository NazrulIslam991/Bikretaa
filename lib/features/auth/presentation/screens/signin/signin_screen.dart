import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/app/controller/theme_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/app/string.dart';
import 'package:bikretaa/features/auth/presentation/database/firestore_user_check.dart';
import 'package:bikretaa/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bikretaa/features/auth/presentation/screens/sign_up/create_account_screen.dart';
import 'package:bikretaa/features/auth/presentation/widgets/auth_botto_text.dart';
import 'package:bikretaa/features/shared/presentation/screens/admin_main_nav_bar_screen.dart';
import 'package:bikretaa/features/shared/presentation/screens/main_nav_bar_screen.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/email_feild_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/password_feild_widget.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
  static const name = 'Signin_name';
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEcontroller = TextEditingController();
  final TextEditingController _passwordEcontroller = TextEditingController();
  bool _signinProgressIndicator = false;
  final ThemeController _themeController = Get.find<ThemeController>();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Login_Headline'.tr,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: r.fontXXXL(),
                        ),
                      ),
                    ),

                    SizedBox(height: r.height(0.05)),

                    Container(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                      ),
                    ),

                    // SizedBox(height: r.height(0.01)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 65.h,
                          child: PasswordFeildWidget(
                            passwordEcontroller: _passwordEcontroller,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Transform.translate(
                            offset: Offset(0, -r.height(0.02)),
                            child: TextButton(
                              onPressed: _onTapForgetPassword,
                              child: Text(
                                'Forgot_password'.tr,
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: r.fontSmall(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //SizedBox(height: r.height(0.01)),
                    Visibility(
                      visible: !_signinProgressIndicator,
                      replacement: CenterCircularProgressIndiacator(),
                      child: SizedBox(
                        //width: double.infinity,
                        //height: r.height(0.05),
                        child: ElevatedButton(
                          onPressed: _onTapSignin,
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
                    ),

                    SizedBox(height: r.height(0.03)),
                    Center(
                      child: AuthBottomText(
                        normalText: 'Sign_in_bottom_text_1'.tr,
                        actionText: 'Sign_in_bottom_text_2'.tr,
                        onTap: _onTapSignUp,
                        //fontSize: r.fontSmall(),
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

  // ------------------ Sign In ------------------
  void _onTapSignin() async {
    if (_formKey.currentState!.validate()) {
      _signInProcess();
    }
  }

  Future<void> _signInProcess() async {
    final email = _emailEcontroller.text.trim();
    final password = _passwordEcontroller.text.trim();

    setState(() => _signinProgressIndicator = true);

    bool userExists = await FirestoreUtils.checkUserExists(email);

    if (!userExists && email != AppConstants.adminEmail) {
      showSnackbarMessage(context, 'No_account_found'.tr);
      setState(() => _signinProgressIndicator = false);
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;
      final userInformation = await FirestoreUtils.getUserInformationByUid(uid);

      if (userInformation != null) {
        await SharedPreferencesHelper.saveUser(userInformation);
      }

      if (email == AppConstants.adminEmail) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AdminMainNavBarScreen.name,
          (predicate) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainNavBarScreen.name,
          (predicate) => false,
        );
      }

      showSnackbarMessage(context, 'Login_successful!'.tr);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No_account_found_for_that_email'.tr;
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect_password_Please_try_again'.tr;
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The_email_address_is_not_valid'.tr;
      } else {
        errorMessage = 'Login_failed_Please_try_again'.tr;
      }
      showSnackbarMessage(context, errorMessage);
    } catch (e) {
      showSnackbarMessage(context, 'An unexpected error occurred: $e');
    } finally {
      setState(() => _signinProgressIndicator = false);
    }
  }

  // ------------------ Forgot Password ------------------
  void _onTapForgetPassword() {
    Navigator.pushReplacementNamed(context, ForgotPasswordScreen.name);
  }

  // ------------------ Sign Up ------------------
  void _onTapSignUp() {
    Navigator.pushReplacementNamed(context, CreateAccountScreen.name);
  }
}
