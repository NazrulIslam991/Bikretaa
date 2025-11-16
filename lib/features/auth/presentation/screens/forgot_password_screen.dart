import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/app/string.dart';
import 'package:bikretaa/features/auth/presentation/database/firestore_user_check.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/auth/presentation/widgets/auth_botto_text.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/email_feild_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/responsive.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
  static const name = '/Forgot_password';
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailEcontroller = TextEditingController();
  bool _forgotPasswordProgressIndicator = false;

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
                        'Forgot_password'.tr,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: r.fontXXXL(),
                        ),
                      ),
                    ),

                    SizedBox(height: r.height(0.005)),

                    Center(
                      child: Text(
                        'Please_enter_email_address_to_reset_the_password'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: theme.colorScheme.primary,
                          letterSpacing: 0.4,
                          fontStyle: FontStyle.italic,
                          fontSize: r.fontSmall(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: r.height(0.05)),

                    Container(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                      ),
                    ),

                    //SizedBox(height: r.height(0.04)),
                    Visibility(
                      visible: !_forgotPasswordProgressIndicator,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: _onTapResetLinkSend,
                        child: Text(
                          'Reset_Link'.tr,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: r.fontSmall(),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: r.height(0.03)),

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

  // Start the send password reset link
  void _onTapResetLinkSend() {
    if (_formKey.currentState!.validate()) {
      _sendPasswordResetLinkProcess();
    }
  }

  Future<void> _sendPasswordResetLinkProcess() async {
    final email = _emailEcontroller.text.trim();

    setState(() {
      _forgotPasswordProgressIndicator = true;
    });

    bool userExists = await FirestoreUtils.checkUserExists(email);

    if (!userExists && email != AppConstants.adminEmail) {
      showSnackbarMessage(context, 'No_account_found_for_that_email'.tr);
      setState(() {
        _forgotPasswordProgressIndicator = false;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      showSnackbarMessage(
        context,
        'Password_Reset_Link_sent_successfully_Check_your_email'.tr,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninScreen.name,
        (predicate) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The_email_address_is_not_valid'.tr;
          break;
        case 'too-many-requests':
          errorMessage = 'Too_many_requests_Please_try_again_later'.tr;
          break;
        default:
          errorMessage = e.message ?? "An error occurred. Please try again.";
      }
      showSnackbarMessage(context, errorMessage);
    } catch (e) {
      showSnackbarMessage(context, 'An unexpected error occurred: $e');
    } finally {
      setState(() {
        _forgotPasswordProgressIndicator = false;
      });
    }
  }

  // Sign-in button
  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }
}
